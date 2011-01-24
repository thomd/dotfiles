#
# load bash config, environment and aliases
#
. ~/dotfiles/bash/config

SNOWLEOPARD="$(sw_vers 2>/dev/null | sed -ne 's/\(10\.6\)/\1/p')"
if [[ -n $SNOWLEOPARD ]]; then
. ~/dotfiles/bash/env.10.6
else
. ~/dotfiles/bash/env.10.5
fi

. ~/dotfiles/bash/alias


#
# thomd
#
echo -en ${RED}
echo ' _____ _   _  ___  __  __ ____  '
echo '|_   _| | | |/ _ \|  \/  |  _ \ '
echo '  | | | |_| | | | | |\/| | | | |'
echo '  | | |  _  | |_| | |  | | |_| |'
echo '  |_| |_| |_|\___/|_|  |_|____/ '
echo ''
echo -en $NO_COLOR


#
# ssh-complete (http://drawohara.tumblr.com/post/6584031)
#
SSH_COMPLETE=($(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq))
complete -o default -W "${SSH_COMPLETE[*]}" ssh



#
# Set the title of the terminal window with cd (can't remember where I got this from)
#
function settitle() { echo -ne "\033]0;$@\a"; }
function cd() { command cd "$@"; settitle `pwd | awk 'BEGIN {FS="/"} {print $NF}'`; }



#
# generate rails project based on template (http://github.com/thomd/rails-templates/tree/master)
#
function railst() {
  template=$1
  appname=$2
  shift 2
  rails $appname -m http://github.com/thomd/rails-templates/raw/master/$template.template.rb $@
}



#
# get git-info
#
function git_ps1 {
	local g="$(git rev-parse --git-dir 2>/dev/null)"
	if [ -n "$g" ]; then
		local r
		local b
		if [ -d "$g/../.dotest" ]
		then
			r="|AM/REBASE"
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		elif [ -f "$g/.dotest-merge/interactive" ]
		then
			r="|REBASE-i"
			b="$(cat $g/.dotest-merge/head-name)"
		elif [ -d "$g/.dotest-merge" ]
		then
			r="|REBASE-m"
			b="$(cat $g/.dotest-merge/head-name)"
		elif [ -f "$g/MERGE_HEAD" ]
		then
			r="|MERGING"
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			if [ -f $g/BISECT_LOG ]
			then
				r="|BISECTING"
			fi
			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
			then
				b="$(cut -c1-7 $g/HEAD)..."
			fi
		fi

		if [ -n "$1" ]; then
			printf "$1" "${b##refs/heads/}$r"
		else
			printf " (%s)" "${b##refs/heads/}$r"
		fi
	fi
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}


#
# get svn-info
# 
#   show trunk- or branches-path in prompt for all repositories following the trunk/branches convention
#
svn_ps1() {
	local svn="$(svn info 2>/dev/null)"
	if [ -n "$svn" ]; then
		local rev="$(svn info 2>/dev/null | sed -ne 's#^Revision: ##p')"
		local root="$(svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p')"
		local url="$(svn info 2>/dev/null | sed -ne 's#^URL: '"$root/"'##p' | sed -ne 's/^.*\(trunk\).*$/\1/p;s/^.*\(branches\/[^\/.]*\).*$/\1/p')"
		printf "$1" "svn:$url $rev"
	fi
}

function parse_svn_dirty {
    [[ $(svn status 2> /dev/null) != "" ]] && echo "*"
}


#
# show both git-info and svn-info in prompt
#
export PS1='\n\[\033[00m\]\h \[\033[0;36m\]\W $(git_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_git_dirty)\[\033[0;32m\]]")\[\033[0;32m\]$(svn_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_svn_dirty)\[\033[0;32m\]]")\[\033[0;32m\] \[\033[0m\]$ '
export PS2=" : "


#
# start a tiny web server serving the current directory (http://www.ralfebert.de/blog/tools/www_here/)
#
function www {
    python -c 'import SimpleHTTPServer,SocketServer;PORT=1234;httpd = SocketServer.TCPServer(("", PORT),SimpleHTTPServer.SimpleHTTPRequestHandler); print "serving at port", PORT; httpd.serve_forever()'
}


#
# Define words and phrases with google (http://www.commandlinefu.com/commands/view/4722/define-words-and-phrases-with-google.)
#
define(){ local y="$@";curl -sA"Opera" "http://www.google.com/search?q=define:${y// /+}"|grep -Eo '<li>[^<]+'|sed 's/^<li>//g'|nl|/usr/bin/perl -MHTML::Entities -pe 'decode_entities($_)';}


#
#  Google Translate
#
#    Usage:   translate <phrase> <source-language> <output-language>
#    Example: translate hello en es
#
translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1/'; }


#
# what is my IP?
#
ip(){ curl "http://www.whatismyip.org"; }
