#!/usr/bin/env bash

# polkit
/usr/lib/polkit-1/polkit-agent-helper-1 &

# background
feh --bg-fill  ~/.config/i3/wallpapers/ &

# compositor
picom --config ~/.config/picom/picom.conf -b &

# Notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet --indicator &

# for audio
# wpctl set-default 51
pipewire &

# bluetooth manager
blueman-applet &

# set my brightness, runit doesnt restore
brightnessctl set 10% &

# blue light filter
redshift-gtk &

# battery power management
xfce4-power-manager &

# lockscreen functionality, turns out xfce is nice!
xfce4-screensaver &

# mount and unmount drives
udiskie --automount --notify --smart-tray --file-manager thunar &

# appeanrance settings
lxappearance &
