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
