# vim:ft=sh

if [ `uname` = Linux ]; then
  alias l='ls -AlhG --color=auto'
  alias ack="ack-grep"
else
  alias l='ls -AlhG'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias h='history'
alias l.='ls -ld .[^.]*'                              # list dotfiles only
alias md='mkdir -p'
alias v='vim'

alias t='tree -a -C -I ".git|.svn|node_modules|.gradle|tmp|.sass-cache|.cache"'
alias j='jobs -l'
alias rmi='rm -i'

alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'


# ----- ranger ------------------------------------------------------------------------------------
alias lr="ranger"

# ----- docker ------------------------------------------------------------------------------------
alias d="docker $@"
alias drm="docker ps -aq | xargs docker rm"
dclean() {
  docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}


# ----- git ---------------------------------------------------------------------------------------
function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git branch-status
    echo -e "   Last commit:     \033[0;32m$(time_since_last_commit)\033[0m ago"
    echo -e "   Most recent tag: \033[0;32m$(git describe)\033[0m\n"
    git status --short --branch
  fi
}

function time_since_last_commit() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

alias gb='git branch -a -vv'            # "git branches"
alias gbs='git branch-status'
alias gd='git df'                       # "git diff"
alias gsl='git sl'                      # "git shortlog"
alias gl='git l'                        # "git log"
alias gln='git ln'                      # "git log no-merges"
alias gla='git la'                      # "git log all"
alias glan='git lan'                    # "git log all no-merges"
alias eg='vim .git/config'                                                          # "edit git"
alias gr='git remote -v | column -t'                                                # "git remotes"
alias gt='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup`'   # "git top"   (cd into root folder)


# ----- encoding & decoding -----------------------------------------------------------------------
alias urlencode='python -c "import sys;from urllib.parse import quote;print(quote(sys.argv[1] if sys.stdin.isatty() else sys.stdin.readline().strip()))"'
alias urldecode='python -c "import sys;from urllib.parse import unquote;print(unquote(sys.argv[1] if sys.stdin.isatty() else sys.stdin.readline().strip()))"'

# alternative base conversions with perl
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias d2o="perl -e 'printf qq|%o\n|, int( shift )'"
alias d2b="perl -e 'printf qq|%b\n|, int( shift )'"

alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
alias h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
alias h2b="perl -e 'printf qq|%b\n|, hex( shift )'"

alias o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
alias o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
alias o2b="perl -e 'printf qq|%b\n|, oct( shift )'"

bin2hex() {
  echo "obase=16;ibase=2; $1" | bc
}
alias b2h=bin2hex

bin2dec() {
  echo "ibase=2; $1" | bc
}
alias b2d=bin2dec

bin2oct() {
  echo "ibase=2;obase=8; $1" | bc
}
alias b2o=bin2oct


# ----- tools -------------------------------------------------------------------------------------

# calendar with the current date marked:
alias calender='ncal -w | grep --color=auto -E "( |^)$(date +%e)( |$)|$"'

# print all colors
alias colors='colortest -w -s -r'

# npm-scripter
alias nps="npm-scripter $@"

# meld diff-tool (istall: https://yousseb.github.io/meld/)
alias meld="open -W -a Meld --args $@"

# csvfix
alias csv="csvfix $@"

# VS Code
alias code='code --locale=en $@'

alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

