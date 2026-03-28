#!/usr/bin/env bash

# polkit
/usr/lib/polkit-1/polkit-agent-helper-1 &

# background
# handled in ./../settings/screens.py to allow for random wallpapers
# feh --bg-fill  ~/.config/qtile/wallpapers/ &

# compositor
# start in grayscale mode
picom --config ~/.config/picom/picom.conf -b &

# Notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet --indicator &

# bluetooth manager
blueman-applet &

# restore brightness
brightnessctl set 10% &

# blue light filter
redshift-gtk &

# battery power management
xfce4-power-manager &

# lockscreen functionality, turns out xfce is nice!
xfce4-screensaver &

# for audio
pipewire &

# mount and unmount drives
udiskie --automount --notify --smart-tray --file-manager thunar &
