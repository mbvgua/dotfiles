## Tools

- **OS**: fedora
- **Window manager**: [qtile](https://github.com/qtile/qtile) - An X11/Wayland tiling window manager.
- **Compositor**: [picom](https://github.com/yshui/picom) - A lightweight compositor for X11.
- **Shell**: [bash](https://cgit.git.savannah.gnu.org/cgit/bash.git) - Bash is an interactive command interpreter and programming language developed for Unix-like operating systems.
- **Terminal emulator**: [wezterm](https://github.com/wezterm/wezterm) - A GPU-accelerated cross-platform terminal emulator and multiplexer written and implemented in Rust .
- **Terminal multiplexer**: [tmux](https://github.com/tmux/tmux) - A terminal multiplexer.
- **Text editor**: [neovim](https://github.com/neovim/neovim) - Hyperextensible Vim-based text editor.
- **Version controll**: 
    - [git](https://github.com/git/git) - A free and open source distributed version control system.
    - [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) - Make your diffs human readable instead of machine readable.
    - [sublime merge](https://www.sublimemerge.com) - a cross-platform Git client, done the Sublime Text way.
- **Video/Music player**: [mpv](https://github.com/mpv-player/mpv) - command line media player.
- **Audio player**:
    - [cmus](https://github.com/cmus/cmus) - Small, fast and powerful console music player for Unix-like operating systems.
    - [kew](https://codeberg.org/ravachol/kew) - Music for the Shell
- **Web browser**:
    - [helium](https://github.com/imputnet/helium) - Private, fast, and honest web browser.
    - [qutebrowser](https://github.com/qutebrowser/qutebrowser) - A keyboard-driven, vim-like browser based on Python and Qt
- **App launcher**: [rofi](https://github.com/davatorium/rofi) - A window switcher, application launcher and dmenu replacement.
- **Image viewer**: [feh](https://github.com/derf/feh) - a fast and light image viewer.
- **File manager**:
    - [thunar](https://gitlab.xfce.org/xfce/thunar) - Modern, fast and easy-to-use file manager for Xfce
    - [ranger](https://github.com/ranger/ranger) - a VIM-inspired filemanager for the console .
- **Pdf reader**: [zathura](https://pwmt.org/projects/zathura) - a highly customizable and functional document viewer. It provides a minimalistic and space saving interface as well as an easy usage that mainly focuses on keyboard interaction.
- **Blue light filter**: [redshift](https://github.com/jonls/redshift) - Redshift adjusts the color temperature of your screen according to your surroundings. This may help your eyes hurt less if you are working in front of the screen at night.
- **Notifications**: [dunst](https://github.com/dunst-project/dunst) - A highly configurable and lightweight notification daemon.

### Extras

- CLI
    - [yt-dlp](https://github.com/yt-dlp/yt-dlp) - a feature-rich command-line audio/video downloader.
    - [keyd](https://github.com/rvaiya/keyd) - a key remapping daemon for linux.
    - [eza](https://github.com/eza-community/eza) - a modern alternative to ls.
    - [nm-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) - tray applet and an advanced network connection editor.
    - [blueman-applet](https://github.com/blueman-project/blueman) - a GTK+ Bluetooth Manager.
    - [btop](https://github.com/aristocratos/btop) - Linux/OSX/FreeBSD resource monitor.
    - [paplay](https://linux.die.net/man/1/paplay) - play back audio files on a PulseAudio sound server.
    - [wget](https://cgit.git.savannah.gnu.org/cgit/wget.git) - A free software package for retrieving files using HTTP, HTTPS, FTP, and FTPS.
    - [curl](https://github.com/curl/curl) - a command-line tool for transferring data specified with URL syntax.
- GUI
    - [xfce4-power-manager](https://gitlab.xfce.org/xfce/xfce4-power-manager) - power manager for Xfce.
    - [xfce4-screensaver](https://gitlab.xfce.org/apps/xfce4-screensaver) - a simple screen saver and locker well integrated with Xfce.
    - [deepin-screenshot](https://github.com/martyr-deepin/deepin-screenshot) - 
    - [stow](https://www.gnu.org/software/stow/) - a symlink farm manager, to store and sync your configuration files in one common location.

## How?

Navigate to your `$HOME` directory and:
```bash
    git clone https://codeberg.org/mbugua/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git checkout xorg/fedora
    ./install

    # create symlinks to necessary files
    stow .
```

> [!IMPORTANT]
>
> A neccessary QoL if you are on the `qtile` WM is adding click support, which allows for click actions using the touchpad. This can be done in the config if you are on wayland, but I am yet to migrate ;). In your terminal of choice, input: `sudoedit /usr/share/X11/xorg.conf.d/40-libinput.conf`. Then add the `"Option" "Tapping" "True"` in the below section:
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

