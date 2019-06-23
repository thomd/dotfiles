# vim:ft=sh


# list all folders in PATH environment variable more readable (non existent folders in red)
#
function paths {
  IFS=$':'
  for i in $PATH; do if [ -d $(eval echo $i) ]; then echo $i; else echo -e "\033[0;31m$i\033[0m"; fi; done;
  unset IFS
}


#
# create temporary scratch directory [inspired by http://ku1ik.com/2012/05/04/scratch-dir.html]
#
export SCRATCH_HOME="$HOME/scratch"
export SCRATCH_TEMP="/private/tmp/scratch-"
[[ -h $SCRATCH_HOME && ! -d $SCRATCH_HOME ]] && rm $SCRATCH_HOME     # delete scratch link if /tmp scratch folder doesn't exist anymore
function scratch_new {
  export SCRATCH_TEMP="/private/tmp/scratch-`date +'%s'`/scratch"    # scratch folder with timestamp within /tmp. will be deleted after system reboot
  mkdir -p $SCRATCH_TEMP                                             # create scratch folder
  ln -nfs $SCRATCH_TEMP $SCRATCH_HOME                                # symlink to scratch folder
  cd $SCRATCH_HOME                                                   # cd into scratch folder
}

function scratch_into {
  if [ -h "$SCRATCH_HOME" ]; then                                    # if symbolic link to SCRATCH_HOME exists
    cd $SCRATCH_HOME
  else
    scratch_new
  fi
}

function scratch_go {                                                # setup a temporary go environment
  if [ -d "src" ] && [ -d "pkg" ] && [ -d "bin" ]; then
    export GOPATH=`pwd`
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
  fi
}

alias s="scratch_into"                                               # cd into current scratch folder or create a new one
alias sn="scratch_new"                                               # new empty scratch folder
alias sg="scratch_go"

#
# colored ant
#
function antc {
  if [ -n "$1" ]; then
    ant $1 | colored-ant.pl;
  else
    ant | colored-ant.pl;
  fi;
}


#
# mkdir & cd
#
function mkcd {
  mkdir -p "${1-temp}" && cd "$_"
}


#
# start a tiny web server in a separate tmux pane serving the current directory (see ~/bin/www-server)
#
function www {
  if [ -n "$TMUX" ]; then
    tmux splitw -v -p 10 "www-server $@";
    tmux selectp -t 1;
  else
    www-server "$@";
  fi
}


#
# run arbitrary command in separate tmux pane
#
# EXAMPLE
#
#   > _ htop
#   > _ sass --watch .:.
#
function _ {
  tmux splitw -v -p 15 "$@";
  tmux selectp -t 1;
}


#
# find folder depth
#
function ffd {
  if [ "$1" == "-v" ]; then
    {
      echo "folders depth"
      find . -type d 2>/dev/null | awk -F'/' '{print NF -1}' | sort | uniq -c | sort -nk2
    } | column -t
  else
    find . -type d 2>/dev/null | awk -F'/' '{print NF-1}' | sort -n | tail -1
  fi
}


# cd to project root (determined .git folder)
function p {
  local root=`git root`
  [ `pwd` = "$root" ] && echo -e "\033[1;30mthis is project root"
  cd "$root"
}


# show all the names (CNs and SANs) listed in the SSL certificate for a given domain
function certnames {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "testing ${domain} ..."
  echo # newline

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" | openssl s_client -connect "${domain}:443" 2>&1);

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" | openssl x509 -text -certopt "no_header, no_serial, no_version, no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
    echo "Common Name:"
    echo # newline
    echo "  ${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
    echo # newline
    echo "Subject Alternative Name(s):"
    echo # newline
    echo "  ${certText}" | grep -A 1 "Subject Alternative Name:" | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found.";
    return 1
  fi
}


# cd to the path of the currently opened Finder window
#
#   vice versa: to open the current working directory in the Finder enter `open .`
#
function cdf {
  target=`osascript -e 'tell application "Finder" to get POSIX path of (target of front Finder window as text)'`
  cd "$target"
}


# set docker environment
function dockerenv {
  local name=$(docker-machine ls | awk '$4 == "Running" {print $1}')
  [ "${name}" != "No active host found" ] && eval "$(docker-machine env $name)" || echo -e "\033[0;31m\n  No active docker machine\033[0m"
}


# create a ZIP archive of a file or folder
function zipf {
  zip -r "$1".zip "$1";
}


# create a new basic java project using gradle
function newjava {
  mkdir -p "$@" && cd "$@"
  gradle setupBuild --type java-library
  perl -i -lne 'print $_;print "apply plugin: \x27eclipse\x27" if(/apply/);' build.gradle
  gradle eclipse
  rm -fr src/main/java/Library.java
  rm -fr src/test/java/LibraryTest.java
}


# Escape UTF-8 characters into their 3-byte format
function escape() {
  printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
}


# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
}


# Get a character’s Unicode code point
function codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
}


# gitignore.io
#
# USAGE
#
#   gi list
#   gi java > .gitignore
#
function gi() {
  curl -L -s "https://www.gitignore.io/api/$@"
}


# get internal and external ips
#
#   external IP info is available via:
#
#     curl -H "User-Agent: curl" ipinfo.io | jq -r '.ip'
#     curl -s httpbin.org/ip | jq -r '.origin'
#     dig +short myip.opendns.com @resolver1.opendns.com
#
function ip() {
  if [ "-h" == "$1" ]; then
    cat << EOF
external IP info is available via:

>  curl -H "User-Agent: curl" ipinfo.io | jq -r '.ip'
>  curl -s httpbin.org/ip | jq -r '.origin'
>  dig +short myip.opendns.com @resolver1.opendns.com
EOF
  else
    echo -e "\n \033[1;30mInternal IPs:\033[0m\n"
    ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print "   $1"'
    echo -e "\n \033[1;30mExternal IP:\033[0m\n"
    curl -sH "User-Agent: curl" ipinfo.io | jq -r '. | "   \(.ip)"'
  fi
}


# Truncate each line of the input to X characters
# flag -s STRING (optional): add STRING when truncated
# switch -l (optional): truncate from left instead of right
# param 1: (optional, default 70) length to truncate to
shorten() {
	local helpstring="Truncate each line of the input to X characters\n\t-l              Shorten from left side\n\t-s STRING         replace truncated characters with STRING\n\n\t$ ls | shorten -s ... 15"
	local ellip="" left=false
	OPTIND=1
	while getopts "hls:" opt; do
		case $opt in
			l) left=true ;;
			s) ellip=$OPTARG ;;
			h) echo -e $helpstring; return;;
			*) return 1;;
		esac
	done
	shift $((OPTIND-1))

	if $left; then
		cat | sed -E "s/.*(.{${1-70}})$/${ellip}\1/"
	else
		cat | sed -E "s/(.{${1-70}}).*$/\1${ellip}/"
	fi
}


# ----- sourcing external scripts -----
#
# download
#
#   cd /usr/local/lib && wget https://raw.githubusercontent.com/thomd/fzf-marks/master/fzf-marks.plugin.bash
#
[ -r "/usr/local/lib/fzf-marks.plugin.bash" ] && source "/usr/local/lib/fzf-marks.plugin.bash"

