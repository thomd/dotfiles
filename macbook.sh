#!/usr/bin/env bash

# Xcode
#
# Install Xcode from the App store or the Apple developer website
#
# For installing Xcode command line tools run the command
xcode-select --install

# Homebrew
source ./homebrew.sh

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# fzf-marks
cd /usr/local/lib && wget https://raw.githubusercontent.com/thomd/fzf-marks/master/fzf-marks.plugin.bash

# vim UltiSnips
cd ~/.vim
git clone https://github.com/thomd/ultisnips-snippets.git UltiSnips

# github
#
# generate new SSH key (https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) or use existing
ssh-keygen -t rsa -b 4096 -C "tomduerr@gmail.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/github
ssh-add ~/.ssh/bitbucket


