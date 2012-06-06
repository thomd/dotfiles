#
# load bash config, environment and aliases
#
. ~/dotfiles/bash/config
. ~/dotfiles/bash/env
. ~/dotfiles/bash/alias

#
# thomd
#
echo -en ${RED}
# echo `whoami`@`hostname`
# echo ' _____ _   _  ___  __  __ ____  '
# echo '|_   _| | | |/ _ \|  \/  |  _ \ '
# echo '  | | | |_| | | | | |\/| | | | |'
# echo '  | | |  _  | |_| | |  | | |_| |'
# echo '  |_| |_| |_|\___/|_|  |_|____/ '
# echo ''
echo -en $NO_COLOR


#
# ssh-complete (http://drawohara.tumblr.com/post/6584031)
#
SSH_COMPLETE=($(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq))
complete -o default -W "${SSH_COMPLETE[*]}" ssh


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

function rvm_prompt {
  local rvm="$(~/.rvm/bin/rvm-prompt v g)"
  if [ -n "$rvm" ]; then
    printf "[$rvm] "
  fi
}

#
# show both git-info and svn-info in prompt
#
# export PS1='\n\[\033[00m\]\u \[\033[0;36m\]\W \[\033[1;32m\]$(rvm_prompt)\[\033[0;36m\]$(git_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_git_dirty)\[\033[0;32m\]]")\[\033[0;32m\]$(svn_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_svn_dirty)\[\033[0;32m\]]")\[\033[0;32m\] \[\033[0m\]$ '
export PS1='\n\[\033[0;36m\]\W \[\033[1;32m\]$(rvm_prompt)\[\033[0;36m\]$(git_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_git_dirty)\[\033[0;32m\]]")\[\033[0;32m\]$(svn_ps1 "\[\033[0;32m\][%s\[\033[0m\]\[\033[31m\]$(parse_svn_dirty)\[\033[0;32m\]]")\[\033[0;32m\] \[\033[0m\]$ '
export PS2=" : "


#
# start a tiny web server serving the current directory (http://www.ralfebert.de/blog/tools/www_here/)
#
function www() {
  local port="${1:-8000}"
  open "http://localhost:${port}"
  python -m SimpleHTTPServer $port
}


#
# Set the title of the terminal window with cd (can't remember where I got this from)
#
function settitle() { echo -ne "\033]0;$@\a"; }
function cd() { command cd "$@"; settitle `pwd | awk 'BEGIN {FS="/"} {print $NF}'`; }


#
# list all folders in PATH environment variable more readable (non existent folders in red)
#
function paths(){
  IFS=$':'
  for i in $PATH; do if [ -d $(eval echo $i) ]; then echo $i; else echo -e "\033[0;31m$i\033[0m"; fi; done;
  unset IFS
}


#
# colored ant
#
antc(){
  if [ -n "$1" ]; then
    ant $1 | colored-ant.pl;
  else
    ant | colored-ant.pl;
  fi;
}

#
# automatically correct mistyped directory names
#
shopt -s cdspell

#
# bind backward-word to ctrl-b
# bind forward-word to ctrl-f
#
bind "\C-b":backward-word
bind "\C-f":forward-word

#
# stderred (https://github.com/sickill/stderred)
# for the time being this is commented out as it breaks the 'open' command (see https://github.com/sickill/stderred/issues/11)
#
# export DYLD_INSERT_LIBRARIES=/usr/local/lib/stderred.dylib DYLD_FORCE_FLAT_NAMESPACE=1


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#
# tmuxinator
#
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
