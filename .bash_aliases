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
alias m='mate .'
alias v='vim'
alias ff='open -a Firefox $1'
alias t='tree -a -C -I ".git|.svn|node_modules|.gradle|tmp|.sass-cache"'
alias d='cd ~/dotfiles && [ -n "$TMUX" ] && tmux rename-window "dotfiles"'
alias dt='cd ~/Desktop'
alias so='. ~/.bashrc'                                # source bashrc
alias j='jobs -l'
alias rmi='rm -i'

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
alias gs='git sl'
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
alias ip='curl -H "User-Agent: curl" ipinfo.io'
alias flush="dscacheutil -flushcache" # Flush DNS cache

# URL encode/decode
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

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

# open markdown files in Marked.app
alias md="open -a /Applications/Marked.app/ $1"

# mapping observr (https://github.com/kevinburke/observr) to watchr (which is no longer maintained)
alias watchr="observr"

# print all colors
alias colors='colortest -w -s -r'

# ssh-host-color (from https://gist.github.com/956095)
#alias ssh=~/bin/ssh-host-color.sh

# start a tiny web server serving the current directory (see ~/bin/http-server)
alias www="tmux splitw -v -p 10 http-server $@; tmux selectp -t 1"

# irssi & tmux
alias irssi='TERM=screen-256color irssi'





