<h1 align="center">dotfiles ~/.</h1>

The branches present depend on what OS you're currently on:
- `xorg/fedora`: fedora + qtile wm
- `xorg/void`: void + qtile wm
- `server`:
- `rasp`:

## How?

Navigate to your `$HOME` directory and:
```bash
    git clone https://codeberg.org/mbugua/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    python install.py

    # create symlinks to necessary files
    stow .
```
