<h1 align="center">dotfiles ~/.</h1>

![mbvgua's dotfiles](./images/fastfetch.png)

<p align="center">
    <b>Screenshots</b><br>
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/apps.png">Apps</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/cmus.png">Cmus</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/desktop.png">Desktop</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/mpv.png">Mpv</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/neovim.png">Neovim</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/rofi.png">Rofi</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbvgua/dotfiles/src/branch/main/images/scratchpad.png">Scratchpad</a>&nbsp;&nbsp;&nbsp;
</p>

## How?

Currently, these dots work neatly on fedora systems, if you have another OS, please change the package manager in the [install.py](./install.py) file accordingly; though not all the packages may be present in the official repositories.

To get this up and running, simply navigate to your `$HOME` directory and:
```bash
    git clone https://codeberg.org/mbvgua/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    python install.py

    # create symlinks to necessary files
    stow .
```
> [!IMPORTANT]
>
> A neccessary QoL if you are on the `qtile` WM is adding click support, which allows for click actions using the touchoad. Simply input ` sudoedit /usr/share/X11/xorg.conf.d/40-libinput.conf` and using your `$EDITOR` change add the "Option" "Tapping" "true" in the below class:
 
 ```bash
 Section "InputClass"
         Identifier "libinput touchpad catchall"
         MatchIsTouchpad "on"
         MatchDevicePath "/dev/input/event*"
         Driver "libinput"
         Option "Tapping" "True" # this option here
 EndSection
 ```

