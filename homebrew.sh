#!/usr/bin/env bash
set -e
[ -n "$HOMEBREW_DEBUG" ] && set -x

brew up
brew tap homebrew/aliases
brew install tmux
brew install tree jq hr fzf ack wget htop
brew install caskroom/cask/java

# docker
# se  https://pilsniak.com/how-to-install-docker-on-mac-os-using-brew/
brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve


# apps
brew install caskroom/cask/brew-cask
brew cask install visual-studio-code
