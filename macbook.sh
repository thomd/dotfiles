#!/usr/bin/env bash

# Xcode
#
# Install Xcode from the App store or the Apple developer website
#
# For installing Xcode command line tools run the command
xcode-select --install

# Homebrew
source ./homebrew.sh



# github
# 
# generate new SSH key (https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) or use existing
eval $(ssh-agent -s)
ssh-add ~/.ssh/github


# company settings
npm config set proxy http://proxy3:8080
npm config set strict-ssl false
export http_proxy=http://proxy3:8080
export https_proxy=http://proxy3:8080
