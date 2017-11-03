
# load shell dotfiles
#   ~/.bash_exports      for exports of env variables and to extend $PATH
#   ~/.bash_aliases      for aliases
#   ~/.bash_prompt       bash prompt
#   ~/.bash_functions    for daily work functions
#   ~/.bash_completions  bash completions
#   ~/.bash_company      company specific settings, e.g. proxy
#   ~/.bash_private      for private environment variables (e.g. user:password)
for file in ~/.bash_{exports,aliases,prompt,completions,functions,company}; do
  [ -r "$file" ] && source "$file"
done
unset file


# append history list of current session to HISTFILE (default: make HISTFILE get overwritten each time).
shopt -s histappend

# verify a substituted history expansion (with '!!' or '!$') before executing
shopt -s histverify

# history forever
#histfilefolder="$(date -u +%Y/%m)"
#histfilename="$(date -u +%d.%H.%M.%S)"
#mkdir -p "~/.history/$histfilefolder"
#touch "~/.history/$histfilefolder/$histfilename"
#export HISTFILE="~/.history/$(date -u +%Y/%m/)_$$"

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

# automatically correct mistyped directory names
shopt -s cdspell

# bindings
bind "\C-b":backward-word   # ctrl-b: word backward
bind "\C-f":forward-word    # ctrl-f: word forward

# run gpg agent to allow to use preset passphrases
#eval $(gpg-agent --daemon)

# run ssh agent
eval "$(ssh-agent -s)" > /dev/null
ssh-add -K ~/.ssh/github 2> /dev/null


# run TMUX on startup
#if [[ $SHLVL == "1" ]]; then
#  tmux new-session -A -s "$USER"
#fi

# run `archey` only after a system start
#[ ! -f '/tmp/archey' ] && archey && touch '/tmp/archey'

