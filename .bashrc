
# colors (gist.github.com/thomd/7667642)
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExCxxxDxBxxxxxxxxxxxxx # used by ls(1)
export LS_COLORS='di=1;34:fi=0:ln=1;32:pi=33:so=0:bd=0:cd=0:or=0:mi=0:ex=1;31' # used by tree(1)

# allow less(1) to display colors
export LESS=-RFX

export EDITOR="vim"

export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# ack
#export ACK_COLOR_MATCH='green bold'
#export ACK_COLOR_FILENAME='magenta underline bold'

# Java environment
if [ `uname` = Darwin ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH="$PATH:$JAVA_HOME/bin"
  #export PATH="$PATH:/Applications/eclipse"
  #export REPO="~/.m2/repository"
fi

# homebrew python 2.7
export PATH="$PATH:/usr/local/share/python"
export PYTHONSTARTUP="$HOME/.pythonrc"

# python wirtualenvwrapper
export WORKON_HOME="$HOME/.virtualenvs"
[ -f /usr/local/share/python/virtualenvwrapper_lazy.sh ] && source /usr/local/share/python/virtualenvwrapper_lazy.sh

# html tidy
export HTML_TIDY="$HOME/.tidyrc"

# IO
export PATH="$PATH:/develop/io/io/build/_build/binaries"

# heroku
export PATH="$PATH:/usr/local/heroku/bin"

# npm
export PATH="$PATH:/usr/local/share/npm/bin"

# mad(1)
export MAD_PATH="$HOME/.mad"

# postgresql data
export PGDATA=/usr/local/var/postgres

# groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

#
# list all folders in PATH environment variable more readable (non existent folders in red)
#
function paths {
  IFS=$':'
  for i in $PATH; do if [ -d $(eval echo $i) ]; then echo $i; else echo -e "\033[0;31m$i\033[0m"; fi; done;
  unset IFS
}

#
# common aliases
#
if [ `uname` = Linux ]; then
  alias l="ls -AlhG --color=auto"
  alias ack="ack-grep"
else
  alias l="ls -AlhG"
fi
alias ..="cd .."
alias ...="cd ../.."
alias h='history'
alias l.='ls -ld .[^.]*'                             # list dotfiles only
alias md='mkdir -p'
alias wd="pwd | tr -d '\n' | pbcopy; pwd"            # show cwd and copy
alias m="mate ."
alias v="vim"
alias ff='open -a Firefox $1'
alias t='tree -a -I ".git|.svn|node_modules|.gradle|tmp|.sass-cache"'
alias d='cd ~/dotfiles && [ -n "$TMUX" ] && tmux rename-window "dotfiles"'
alias dt='cd ~/Desktop'
alias so=". ~/.bashrc"                                # source bashrc
alias j="jobs"

# compress javascript using YUI Compressor
alias yuicompressor="java -jar ~/Library/Java/Extensions/yuicompressor.jar --type js $1"

# compress javascript using Google Closure compiler
alias closurecompiler="java -jar ~/Library/Java/Extensions/compiler.jar $1"

# http://portswigger.net/
alias burp='java -jar /usr/local/burpsuite/burpsuite.jar &'

# http://ditaa.sourceforge.net/
alias ditaa='java -jar /usr/local/ditaa/ditaa0_9.jar $1'

alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | \grep -a -o -E "Host\: .*|GET \/.*"'

alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

alias tracegl='node ~/bin/tracegl.js -nolib -no:repl.js'

alias brwe=brew  # fix brew typo

# brew install hr
alias hr="hr '-'"

# git
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias gb='git branch'
alias gc='git commit -v'
alias gd='git diff'
alias gl='git l'
alias gln='git ln'
alias gla='git la'
alias glan='git lan'
alias g='git status -sb'
alias eg='vim .git/config'
alias gr='git remote -v | column -t'
alias gt='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup`'   # cd into git root folder
alias gist='gist -c'

# subversion
alias svnadd='svn --force --depth infinity add .'
alias svndiff='svn-colored-diff'
alias svnlog='svn-colored-log'

# rails
alias rp='touch tmp/restart.txt'
alias sc='./script/console'
alias sg='./script/generate'
alias sp='./script/plugin'
alias ss='./script/server'
alias tl='tail -f log/*.log'

# network
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="dscacheutil -flushcache" # Flush DNS cache

# URL encode/decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'


#
# javascript JsLint Check
#
# download JavaScritpLint from www.javascriptlint.com
#    cp jsl into /usr/local/bin
#    cp jsl.conf into /etc/jsl/jsl.conf
#
function jslint() {
  jsl -conf /etc/jsl/jsl.conf -process $1 # syntax check
}

# Rhino
# put js.jar into ~/Library/Extensions
# to enable up-arrow command completion in Rhino, put jline.jar (http://jline.sourceforge.net/) into ~/Library/Java/Extensions/
#alias rhino="java jline.ConsoleRunner org.mozilla.javascript.tools.shell.Main"
#alias rhinod="java org.mozilla.javascript.tools.debugger.Main"

# Rhino Javascript to JavaClass Compiler
alias jsc="java -jar ~/Library/Java/Extensions/jsc.jar $1"


# Clojure REPL with jline
# copy clojure.jar into ~/Library/Java/Extension
alias clojure="java jline.ConsoleRunner clojure.main"

# alternative base conversions with perl (from http://use.perl.org/~brian_d_foy/journal/36287)
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias d2o="perl -e 'printf qq|%o\n|, int( shift )'"
alias d2b="perl -e 'printf qq|%b\n|, int( shift )'"

alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
alias h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
alias h2b="perl -e 'printf qq|%b\n|, hex( shift )'"

alias o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
alias o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
alias o2b="perl -e 'printf qq|%b\n|, oct( shift )'"

# calendar with the current date marked:
alias cal='ncal -w | grep --color=auto -E "( |^)$(date +%e)( |$)|$"'

# tree (from http://mama.indstate.edu/users/ice/tree/)
alias tree="tree -C"

# open markdown files in Marked.app
alias md="open -a /Applications/Marked.app/ $1"

# mapping observr (https://github.com/kevinburke/observr) to watchr (which is no longer maintained)
alias watchr="observr"


#
# source private environment variables (e.g. user:password)
#
[[ -f ~/.bashrc_private ]] && . ~/.bashrc_private


#
# colors
#
RESET="\033[0m"
RED="\033[0;31m"
LIGHT_RED="\033[1;31m"
VERY_RED="\033[38;5;196m"
GREY="\033[1;30m"
LIGHT_GREEN="\033[1;32m"
GREEN="\033[0;32m"
BLUE="\033[0;36m"

alias colors='colortest -w -s -r'


#
# History
#

# append history list of current session to HISTFILE (default: make HISTFILE get overwritten each time).
# shopt -s histappend

# verify a substituted history expansion (with '!!' or '!$') before executing
shopt -s histverify

# increase the history size
export HISTSIZE=1000
export HISTFILESIZE=20000

# add date/time to the history
export HISTTIMEFORMAT="%d/%m/%Y %H:%M:%S  "

# HISTIGNORE controls the items which get ignored and do not get saved.
# ignore duplicate commands, commands that begin with a space, the history alias 'h' and the 'exit' command.
export HISTIGNORE="&:[ ]*:exit"



# disable mail notification
unset MAILCHECK

# default umask
umask 0022

#
# ssh-completion
#
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

#
# ssh-host-color (from https://gist.github.com/956095)
#
# alias ssh=~/bin/ssh-host-color.sh


#
# GIT info for prompt
#
# usage in PS1:
#   $(git_ps1 "$GREEN[%s$RED$(parse_git_dirty)$GREEN]")
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
  [[ $(git status 2> /dev/null | tail -n1) != nothing\ to\ commit* ]] && echo "*"
}

function parse_git_stash {
  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo "^"
}


#
# SVN info: show trunk- or branches-path in prompt for all repositories following the trunk/branches convention
#
# usage in PS1:
#   $(svn_ps1 "$GREEN[%s$RED$(parse_svn_dirty)$GREEN]")
#
function svn_ps1 {
  local svn="$(svn info 2>/dev/null)"
  if [ -n "$svn" ]; then
    local rev="$(svn info 2>/dev/null | sed -ne 's#^Revision: ##p')"
    local root="$(svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p')"
    local url="$(svn info 2>/dev/null | sed -ne 's#^URL: '"$root/"'##p' | sed -ne 's/^.*\(trunk\).*$/\1/p;s/^.*\(branches\/[^\/.]*\).*$/\1/p')"
    local info="$url:$rev"
    [[ $url == '' ]] && info="svn:$rev"    # if not trunk/branches
    printf "$1$RESET" "$info"
  fi
}

function parse_svn_dirty {
    [[ $(svn status 2> /dev/null) != "" ]] && echo "*"
}


#
# create temporary scratch directory [inspired by http://ku1ik.com/2012/05/04/scratch-dir.html]
#
export SCRATCH_HOME="$HOME/scratch"
[[ -h $SCRATCH_HOME && ! -d $SCRATCH_HOME ]] && rm $SCRATCH_HOME     # delete scratch link if scratch folder doesn't exist anymore
function scratch {
  local NEW="/tmp/scratch-`date +'%s'`"                              # scratch folder with timestamp in /tmp. will be deleted after system reboot
  mkdir -p $NEW                                                      # create scratch folder
  ln -nfs $NEW $SCRATCH_HOME                                         # symlink to scratch folder
  cd $SCRATCH_HOME                                                   # cd into scratch folder
  if [ -n "$TMUX" ]; then
    tmux rename-window 'scratch';                                    # set tmux window
  fi
}
alias s="scratch $@"

#
# set color of scratch prompt
#
# usage in PS1:
#   $(scratch_ps1 \W $RED)
#
function scratch_ps1 {
  local args=($@)
  local n=$((${#args[@]}-1))
  local dir=${args[@]:0:$n}                                          # directory-names with spaces
  local color=${args[@]:$n}                                          # color

  if [[ $PWD =~ ^$SCRATCH_HOME ]]; then
    echo -e "$color$dir$RESET"
  else
    [[ $PWD == $HOME ]] && echo -e "$BLUE~$RESET" || echo -e "$BLUE$dir$RESET"
  fi
}


#
# job prompt
#
# usage in PS1:
#   $(job_ps1 \j $GREY)
#
function job_ps1 {
  [ $1 -gt 0 ] && echo -e "$2[$1]$RESET "
}


#
# show job-, scratch-, git- and svn-info in prompt
#
# usage in PS1:
#   $(prompt_ps1 ">" $LIGHT_RED)
#
function prompt_ps1 {
  echo -e "$2$1$RESET "
}

export PS1='\n$(job_ps1 \j $GREY)$(scratch_ps1 \W $RED) $(git_ps1 "$GREEN[%s$RED$(parse_git_dirty)$GREEN$LIGHT_RED$(parse_git_stash)$GREEN]")$(svn_ps1 "$GREEN[%s$RED$(parse_svn_dirty)$GREEN]") $(prompt_ps1 ">" $GREY)'
export PS2=" $LIGHT_RED:$RESET "

# TODO http://blog.yjl.im/2011/02/error-code-deserves-its-own-line.html

#
# start a tiny web server serving the current directory (http://www.ralfebert.de/blog/tools/www_here/)
#
function www {
  local port="${1:-8000}"
  open -g -a /Applications/Firefox.app "http://localhost:${port}"
  python -m SimpleHTTPServer $port
}


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
# perlbrew
#
[ -f /Users/thomd/perl5/perlbrew/etc/bashrc ] && source /Users/thomd/perl5/perlbrew/etc/bashrc


#
# stderred (https://github.com/sickill/stderred)
# for the time being this is commented out as it breaks the 'open' command (see https://github.com/sickill/stderred/issues/11)
#
# export DYLD_INSERT_LIBRARIES=/usr/local/lib/stderred.dylib DYLD_FORCE_FLAT_NAMESPACE=1


#
# tmuxinator
#
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


#
# https://github.com/schneems/explain_shell
#
function explain {
  # base url with first command already injected
  # $ explain tar
  #   => http://explainshel.com/explain/tar?args=
  url="http://explainshell.com/explain/$1?args="

  # removes $1 (tar) from arguments ($@)
  shift;

  # iterates over remaining args and adds builds the rest of the url
  for i in "$@"; do
    url=$url"$i""+"
  done

  # opens url in browser
  open $url
}


#
# mkdir & cd
#
function mkcd {
  mkdir -p "$@" && cd "$_"
}


#
# mvd - move down
# move all files & folders in current directory into a new folder one hierarchy down
#
# EXAMPLE
#
#   > tree
#   .
#   ├── .bar
#   └── baz
#
#   > mvd foo
#   > tree
#   .
#   └── foo
#       ├── .bar
#       └── baz
#
function mvd {
  if [ ! -z "$1" ] && [ "$(ls -A)" ]; then  # if argument given and folder not empty
    local tmp=`mktemp -d mvdXXXX`
    mkdir -p "$tmp"
    for f in $(ls -A); do
      [ "$f" != "$tmp" ] && mv "$f" "$tmp"
    done
    mv "$tmp" "$1"
  else
    echo "usage: mvd <folder>"
  fi
}

#
# mvu - move up
# move all files & folders in a folder one hierarchy up and deletes the - now empty - folder
#
# EXAMPLE
#
#   > tree
#   .
#   └── foo
#       ├── .bar
#       └── baz
#
#   > mvu foo
#   > tree
#   .
#   ├── .bar
#   └── baz
#
function mvu {
  if [ ! -z "$1" ] && [ -d "$1" ]; then  # if argument given and folder exist
    for f in $(ls "$1"); do
      mv "$1/$f" "$PWD"
    done
    rm -r "$1"
  else
    echo "usage: mvu <folder>"
  fi
}

#
# find directory/folder depth
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
alias fdd=ffd

#
# Vagrant
#
if [ `uname` = Darwin ]; then

  # virtualbox for vagrant
  export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/

  # vagrant-bash-completion (https://kura.io/vagrant-bash-completion/)
  [ -f `brew --prefix`/etc/bash_completion.d/vagrant ] && source `brew --prefix`/etc/bash_completion.d/vagrant
fi


# open my side-projects file
projects() {
  ${EDITOR:-vi} "/develop/PROJECTS"
}


# cd to project root (determined .git folder)
p() {
  local root=`git root`
  [ `pwd` = "$root" ] && echo -e "${GREY}this is project root"
  cd "$root"
}


#
# rbenv (brew install rbenv ruby-build)
#
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#
# boot2docker & docker
#
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
[ -f /usr/local/etc/bash_completion.d/docker ] && source /usr/local/etc/bash_completion.d/docker


#
# bash completions
#

#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Homebrew
[ -f $(brew --repository)/Library/Contributions/brew_bash_completion.sh ] && source $(brew --repository)/Library/Contributions/brew_bash_completion.sh

# git bash completion
[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash
[ -f /usr/local/etc/bash_completion.d/git-flow-completion.bash ] && source /usr/local/etc/bash_completion.d/git-flow-completion.bash

# Go lang
if [ `uname` = Darwin ]; then
  export PATH=$PATH:/usr/local/Cellar/go/1.2/libexec/bin
  [ -f /usr/local/etc/bash_completion.d/go-completion.bash ] && source /usr/local/etc/bash_completion.d/go-completion.bash
fi

# play framework
if [ `uname` = Darwin ]; then
  [ -f /usr/local/etc/bash_completion.d/play_completion ] && source /usr/local/etc/bash_completion.d/play_completion
else
  export PATH=$PATH:/develop/play/play
  [ -f /etc/bash_completion.d/play_completion ] && source /etc/bash_completion.d/play_completion
fi

# gradle build tool
[ -f /usr/local/etc/bash_completion.d/gradle ] && source /usr/local/etc/bash_completion.d/gradle

# travis-ci
[ -f /Users/thomd/.travis/travis.sh ] && source /Users/thomd/.travis/travis.sh

# password store
[ -f /usr/local/etc/bash_completion.d/password-store ] && source /usr/local/etc/bash_completion.d/password-store

