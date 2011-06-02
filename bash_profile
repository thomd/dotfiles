# Check for bash rc and source it. All changes to that file.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#echo -en ${YELLOW}
#echo "RUBY: $(~/.rvm/bin/rvm-prompt s i v)"
#echo -en $NO_COLOR
