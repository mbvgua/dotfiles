#!/usr/bin/env bash



#install the tools
# git
# bash
# vim

# create the directory
```
    $ cd ~
    $ mkdir .dotfiles
    $ cd .dotfiles
```

# create the subdirectories
```
    $ mkdir bash vim git
```

#symbolicly link files to each other
```
    $ ln -s ~/.vimrc vim/.vimrc
    $ ln -s ~/.bashrc bash/.bashrc
    $ ln -s ~/.gitconfig git/.gitconfig
```