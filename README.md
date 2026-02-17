<h1 align="center">dotfiles ~/.</h1>

![.](./images/fastfetch.png)

<p align="center">
    <b>Screenshots</b><br>
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/apps.png">Apps</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/cmus.png">Cmus</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/desktop.png">Desktop</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/mpv.png">Mpv</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/neovim.png">Neovim</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/rofi.png">Rofi</a>&nbsp;&nbsp;&nbsp;
    <a href="https://codeberg.org/mbugua/dotfiles/src/branch/main/images/scratchpad.png">Scratchpad</a>&nbsp;&nbsp;&nbsp;
</p>

## What?

- **OS**: fedora
- **window manager**: qtile
- **compositor**: picom
- **shell**: bash
- **terminal emulator**: wezterm
- **terminal multiplexer**: tmux
- **text editor**: nvim
- **version controll**: git
- **video player/music player**: mpv
- **audio player**: cmus
- **web browser**: helium/qutebrowser
- **app launcher**: rofi
- **image viewer**: feh
- **file manager**: thunar/ranger
- **pdf reader**: zathura
- **blue light**: redshift
- **notifications**: dunst

## How?

Navigate to your `$HOME` directory and:
```bash
    git clone https://codeberg.org/mbugua/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    python install.py

    # create symlinks to necessary files
    stow .
```

> [!IMPORTANT]
>
> A neccessary QoL if you are on the `qtile` WM is adding click support, which allows for click actions using the touchpad. This can be done in the config if you are on wayland, but here we are ;) `sudoedit /usr/share/X11/xorg.conf.d/40-libinput.conf`. Then add the `"Option" "Tapping" "True"` in the below section:
>  
>  ```bash
>  Section "InputClass"
>          Identifier "libinput touchpad catchall"
>          MatchIsTouchpad "on"
>          MatchDevicePath "/dev/input/event*"
>          Driver "libinput"
>          Option "Tapping" "True" # this option here
>  EndSection
>  ```

