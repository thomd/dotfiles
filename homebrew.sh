#!/usr/bin/env bash
set -e
[ -n "$HOMEBREW_DEBUG" ] && set -x

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew up
brew tap homebrew/aliases
brew install tmux tree jq hr fzf ack wget htop
brew install git git-flow bash-completion

# nodejs
brew install nvm
mkdir ~/.nvm
export NVM_DIR=$HOME/.nvm
. /usr/local/opt/nvm/nvm.sh
nvm install --lts

# to see which versions are currently installed:
#   /usr/libexec/java_home -V
#
# see also: http://mattshomepage.com/articles/2016/May/22/java_home_mac_os_x/
brew cask install java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# docker
# se  https://pilsniak.com/how-to-install-docker-on-mac-os-using-brew/
brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve


# apps
brew tap caskroom/cask
brew cask install google-chrome
brew cask install iterm2
brew cask install visual-studio-code


# update personal addresses in
#   .npmrc
#   .gitconfig
