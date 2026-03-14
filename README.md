<h1 align="center">dotfiles ~/.</h1>

Choose a branch depending on the OS currently in use:
- `xorg/fedora`: gnu/linux + fedora + qtile wm

## How?

Navigate to your `$HOME` directory and:
```bash
    git clone https://codeberg.org/mbugua/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git checkout [branch name]
    ./install

    # create symlinks to necessary files
    stow .
```
