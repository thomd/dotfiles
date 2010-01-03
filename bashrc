#
# load bash config, environment ans aliases
#
. ~/dotfiles/bash/config
. ~/dotfiles/bash/env
. ~/dotfiles/bash/alias


#
# thomd
#
echo -en $RED
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
function settitle() { echo -ne "\e]0;$@\a"; }
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
# gembox (http://aussiegeek.net/posts/19-Gembox) 
#
export GEMDIR=`gem env gemdir`

gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc



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
parse_svn_url() {
        svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}

parse_svn_repository_root() {
        svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

parse_svn_current_revision() {
        svn info 2>/dev/null | sed -ne 's#^Revision: ##p'
}

parse_svn_branch_revision() {
	parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print $1 "/" $2 }' | awk '{print "[SVN:_@" $1 "]" } ' | sed -e 's#_@#'"$(parse_svn_current_revision)"' #g'	
}


#
# show git-info and svn-info in prompt
#
export PS1='\n\[\e[00m\]\h \[\e[0;36m\]\W $(git_ps1 "\[\e[0;32m\][%s\[\e[0m\]\[\e[31m\]$(parse_git_dirty)\[\e[0;32m\]]")\[\e[0;32m\]$(parse_svn_branch_revision) \[\e[0m\]$ '
export PS2=" : "



#
# rake completion (http://onrails.org/articles/2006/08/30/namespaces-and-rake-command-completion)
#
complete -C ~/bin/rake-completion -o default rake


#
# start a tiny web server serving the current directory (http://www.ralfebert.de/blog/tools/www_here/)
#
function www {
    python -c 'import SimpleHTTPServer,SocketServer;PORT=1234;httpd = SocketServer.TCPServer(("", PORT),SimpleHTTPServer.SimpleHTTPRequestHandler); print "serving at port", PORT; httpd.serve_forever()'
}
