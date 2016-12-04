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
alias cwd="pwd | tr -d '\n' | pbcopy; pwd"            # show cwd and copy
alias v='vim'
alias ff='open -a Firefox $1'
alias t='tree -a -C -I ".git|.svn|node_modules|.gradle|tmp|.sass-cache"'
alias so='. ~/.bashrc'                                # source bashrc
alias j='jobs -l'
alias rmi='rm -i'

# code
alias code='code --locale=en $@'

# compress javascript using YUI Compressor
alias yuicompressor="java -jar ~/Library/Java/Extensions/yuicompressor.jar --type js $1"

# compress javascript using Google Closure compiler
alias closurecompiler="java -jar ~/Library/Java/Extensions/compiler.jar $1"

# http://portswigger.net/
alias burp='java -jar /usr/local/burpsuite/burpsuite.jar &'

alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | \grep -a -o -E "Host\: .*|GET \/.*"'

alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

alias tracegl='node ~/bin/tracegl.js -nolib -no:repl.js'

alias brwe=brew  # fix brew typo

# brew install hr
alias hr="hr '-'"

# docker
alias d="docker $@"
alias dm="docker-machine $@"
alias dc="docker-compose $@"

# git
alias gb='git branch -a'                # "git branches"
alias gbs='git branch-status'
alias gd='git df'                       # "git diff"
alias gsl='git sl'                      # "git shortlog"
alias gl='git l'                        # "git log"
alias gln='git ln'                      # "git log no-merges"
alias gla='git la'                      # "git log all"
alias glan='git lan'                    # "git log all no-merges"
alias g='git status -sb'
alias eg='vim .git/config'                                                          # "edit git"
alias gr='git remote -v | column -t'                                                # "git remotes"
alias gt='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup`'   # "git top"   (cd into root folder)
alias gs='git show `gln | termenu -p | awk "{print \\$1}"`'                         # "git show"
alias gist='gist -c'

# subversion
alias svnadd='svn --force --depth infinity add .'
alias svndiff='svn-colored-diff'
alias svnlog='svn-colored-log'

# network
alias flush="dscacheutil -flushcache" # Flush DNS cache

# URL encode/decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

# Rhino Javascript to JavaClass Compiler
alias jsc="java -jar ~/Library/Java/Extensions/jsc.jar $1"

# Clojure REPL with jline
# copy clojure.jar into ~/Library/Java/Extension
alias clojure="java jline.ConsoleRunner clojure.main"

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

# calendar with the current date marked:
alias cal='ncal -w | grep --color=auto -E "( |^)$(date +%e)( |$)|$"'

# open markdown files in Marked.app
alias md="open -a /Applications/Marked.app/ $1"

# print all colors
alias colors='colortest -w -s -r'

# irssi & tmux
alias irssi='TERM=screen-256color irssi'





