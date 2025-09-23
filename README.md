<h1> Installation </h1>

To install this onto your system, run:

```bash
    git clone https://github.com/mbvgua/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    python install.py

    # create symlinks to necessary files
    stow .
```

> [!IMPORTANT]
> It might be a good idea to back up existing files of the same name as they will be replaced. A good place to customize would be the `.gitconfig` file, change existing variable names to yours
> 
> Also ensure you already have `python ` installed on your system, since the script depends on it to execute.
>
> For the `qtile` wm, you need to manually add the click options for Xorg to allow click actions using the touchoad. Simply navigate to the `/usr/share/X11/xorg.conf.d/40-libinput.conf` file and add the "Option" "Tapping" "true" in the below class:
```bash

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "True" # this option here
EndSection
```
