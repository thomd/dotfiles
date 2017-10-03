# dotfiles

My public dot- and bin-files.

## Install

To install them in your home directory:

    cd ~
    git clone git://github.com/thomd/dotfiles.git
    cd dotfiles
    make install

To install them from outside `$HOME`:

    git clone git://github.com/thomd/dotfiles.git
    make -f dotfiles/Makefile SRCDIR=dotfiles DESTDIR=~

## Setup on OSX

First install [Homebrew][homebrew] and all packages from `homebrew.sh`:

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ./homebrew.sh
    cd ~
    git clone git://github.com/thomd/dotfiles.git
    cd dotfiles
    make install
    cd /usr/local/lib && wget https://raw.githubusercontent.com/thomd/fzf-marks/master/fzf-marks.plugin.bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Setup on Debian Linux


[homebrew]: https://brew.sh
