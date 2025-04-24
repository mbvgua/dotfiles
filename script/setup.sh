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
    $ mkdir bash vim git tmux
```

#install programs that do not come automatically -> tmux
# chack other programs. if installed, print to terminal


#symbolicly link files to each other
```
    $ ln -s ~/.vimrc vim/.vimrc
    $ ln -s ~/.bashrc bash/.bashrc
    $ ln -s ~/.gitconfig git/.gitconfig
    $ ln -s ~/.tmux.conf tmux/.tmux.conf
```

# print done to terminal
