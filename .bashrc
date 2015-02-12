# vim:tw=400

# colors (gist.github.com/thomd/7667642)
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExCxxxDxBxxxxxxxxxxxxx # used by ls(1)
export LS_COLORS='di=1;34:fi=0:ln=1;32:pi=33:so=0:bd=0:cd=0:or=0:mi=0:ex=1;31' # used by tree(1)

# allow less(1) to display colors
export LESS=-RFX

export EDITOR="vim"

export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export PATH="$PATH:/usr/local/heroku/bin"

# npm
export PATH="$PATH:/usr/local/share/npm/bin"

# mad(1)
export MAD_PATH="$HOME/.mad"
export MAD_CONFIG="$HOME/.mad.conf"

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
alias l='ls -AlhG --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias h='history'
alias l.='ls -ld .[^.]*'                             # list dotfiles only
alias md='mkdir -p'
alias wd="pwd | tr -d '\n' | pbcopy; pwd"            # show cwd and copy
alias m='mate .'
alias v='vim'
alias ff='open -a Firefox $1'
alias t='tree -a -I ".git|.svn|node_modules|.gradle|tmp|.sass-cache"'
alias d='cd ~/dotfiles && [ -n "$TMUX" ] && tmux rename-window "dotfiles"'
alias dt='cd ~/Desktop'
alias so='. ~/.bashrc'                                # source bashrc
alias j='jobs -l'
alias rmi='rm -i'

alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | \grep -a -o -E "Host\: .*|GET \/.*"'

alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

# git
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias gb='git branch -a'
alias gc='git commit -v'
alias gd='git df'
alias gl='git l'
alias gln='git ln'
alias gla='git la'
alias glan='git lan'
alias g='git status -sb'
alias eg='vim .git/config'
alias gr='git remote -v | column -t'
alias gt='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup`'   # cd into git root folder
alias gf='git fetch'
alias gist='gist -c'

# network
#alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
#alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
#alias ip='curl -H "User-Agent: curl" ipinfo.io'
#alias flush="dscacheutil -flushcache" # Flush DNS cache

# URL encode/decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

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

# tree (from http://mama.indstate.edu/users/ice/tree/)
alias tree="tree -C"

# open markdown files in Marked.app
alias md="open -a /Applications/Marked.app/ $1"



#
# source private environment variables (e.g. user:password)
#
[[ -f ~/.bashrc_private ]] && . ~/.bashrc_private


#
# colors
#
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
      printf "$1 " "${b##refs/heads/}$r"
    else
      printf " (%s) " "${b##refs/heads/}$r"
    fi
  fi
}

function git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != nothing\ to\ commit* ]] && echo "*"
}

function git_stash {
  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo "^"
}

function git_ahead {
  local s="$(git status -sb 2> /dev/null | awk '/ahead/ {gsub(/^.*\[|\]/, "", $0); print $0}')"
  if [ -n "$s" ]; then
    echo -e " $s" | sed "s/ahead \([0-9][0-9]*\)/↑$1\1/g" | sed 's/, behind [0-9][0-9]*//g'
  fi
}

function git_behind {
  local s="$(git status -sb 2> /dev/null | awk '/behind/ {gsub(/^.*\[|\]/, "", $0); print $0}')"
  if [ -n "$s" ]; then
    echo -e " $s" | sed "s/behind \([0-9][0-9]*\)/↓$1\1/g" | sed 's/ahead [0-9][0-9]*, //g'
  fi
}

#
# SVN info: show trunk- or branches-path in prompt for all repositories following the trunk/branches convention
#
function svn_ps1 {
  local svn="$(svn info 2>/dev/null)"
  if [ -n "$svn" ]; then
    local rev="$(svn info 2>/dev/null | sed -ne 's#^Revision: ##p')"
    local root="$(svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p')"
    local url="$(svn info 2>/dev/null | sed -ne 's#^URL: '"$root/"'##p' | sed -ne 's/^.*\(trunk\).*$/\1/p;s/^.*\(branches\/[^\/.]*\).*$/\1/p')"
    local info="$url:$rev"
    [[ $url == '' ]] && info="svn:$rev"    # if not trunk/branches
    printf "$1" "$info"
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
# prompt job info
#
function job_ps1 {
  [ $1 -gt 0 ] && echo -e "[$1] "
}


#
# prompt delimiter
#   If there is an absolute must, I do `sudo bash` which makes me root but with my environment
#
function delimiter_ps1 {
  if [[ $UID == 0 ]]; then
    echo -e "#"
  else
    echo -e ">"
  fi
}


export PS1='\n\[\e[1;33m\]$(job_ps1 \j)$([[ $PWD =~ ^$SCRATCH_HOME ]] && echo -e "\[\e[38;5;196m\]" || echo -e "\[\e[38;5;244m\]")\W $(git_ps1 "\[\e[0;32m\][%s\[\e[0;31m\]$(git_dirty)\[\e[38;5;208m\]$(git_stash)\[\e[1;30m\]$(git_ahead "\[\e[0;32m\]")\[\e[1;30m\]$(git_behind "\[\e[0;31m\]")\[\e[0;32m\]]")\[\e[1;33m\]$(delimiter_ps1)\[\e[m\] '
export PS2=' \[\e[1;30m\]:\[\e[m\] '




#
# start a tiny web server serving the current directory
#
alias www="http-server $@"

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

