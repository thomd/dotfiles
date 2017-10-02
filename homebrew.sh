#!/usr/bin/env bash
set -e
[ -n "$HOMEBREW_DEBUG" ] && set -x

brew up
brew tap homebrew/aliases
brew install tmux
brew install tree jq hr fzf ack wget
brew install docker docker-compose
brew install caskroom/cask/java

# apps
brew install caskroom/cask/brew-cask
brew cask install visual-studio-code
