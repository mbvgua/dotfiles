#!/usr/bin/env bash

# polkit auth agent
/usr/libexec/xfce-polkit &

# battery power management
xfce4-power-manager &

# lockscreen functionality, turns out xfce is nice!
xfce4-screensaver &

# ensure qtile inherits xfce settings!!
xfsettingsd &

# for audio
pipewire &

# compositor, prevents screen tearing
picom --config ~/.config/picom/picom.conf -b &

# get de/wm independent notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet --indicator &

# bluetooth manager
blueman-applet &

# restore brightness. runit doesnt recall previous session
brightnessctl set 10% &

# blue light filter. my eyess!!
redshift-gtk &

# mount and unmount drives
udiskie --automount --notify --smart-tray --file-manager thunar &
