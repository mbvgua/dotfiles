import os
import subprocess
import random

from libqtile import hook, widget, bar, qtile
from libqtile.command.base import expose_command
from libqtile.lazy import lazy
from libqtile.config import Screen

from .colours import *
from .keybindings import terminal

colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# =====================
# Wallpapers
# =====================

WALLPAPER_DIR = os.path.expanduser("~/.config/qtile/wallpapers")


# Store assigned wallpapers per workspace
wallpapers_by_group = {}


def set_wallpaper_for_group(group_name):
    global wallpapers_by_group
    if group_name in wallpapers_by_group:
        # Already has one → reuse
        chosen = wallpapers_by_group[group_name]
    else:
        # Assign a new one
        wallpapers = []
        for root, dirs, files in os.walk(WALLPAPER_DIR):
            for f in files:
                if f.lower().endswith((".jpg", ".jpeg", ".png")):
                    wallpapers.append(os.path.join(root, f))
        if not wallpapers:
            return
        chosen = random.choice(wallpapers)
        wallpapers_by_group[group_name] = chosen
    # Actually set it
    subprocess.run(["feh", "--bg-fill", chosen])


@hook.subscribe.startup_once
def startup_wallpaper():
    # Set wallpaper for the initial group
    set_wallpaper_for_group(qtile.current_group.name)


@hook.subscribe.setgroup
def change_wallpaper():
    set_wallpaper_for_group(qtile.current_group.name)


# =====================
# Screens
# =====================

widget_defaults = dict(
    font="JetBrains Mono Nerd Font 11",
    fontsize=21,
    padding=4,
    background=backgroundColor,
    foreground=foregroundColor,
)

extension_defaults = widget_defaults.copy()


# Custom separator to match Polybar
def create_separator():
    return widget.TextBox(
        text="|",
        foreground=foregroundColorTwo,  # disabled color
        padding=5,
        fontsize=19,
    )


screens = [
    Screen(
        top=bar.Bar(
            [
                # Left modules - Layout & System Info
                widget.Spacer(length=8),
                widget.CurrentLayout(foreground=foregroundColorTwo, padding=4),
                widget.CurrentLayoutIcon(
                    custom_icon_paths=[
                        os.path.expanduser("~/.config/qtile/icons/layouts")
                    ],
                    foreground=colors[8][0],
                    scale=0.6,
                    # icon_first=True,
                ),
                create_separator(),
                widget.GroupBox(
                    disable_drag=True,
                    use_mouse_wheel=False,
                    active=foregroundColor,
                    inactive=foregroundColorTwo,
                    highlight_method="line",
                    highlight_color=[backgroundColor, backgroundColor],
                    this_current_screen_border=colors[8][0],
                    this_screen_border=colors[1][0],
                    other_current_screen_border=colors[1][0],
                    other_screen_border=backgroundColor,
                    urgent_alert_method="text",
                    urgent_text=colors[9][0],
                    rounded=False,
                    borderwidth=3,
                    # hides unused workspaces
                    hide_unused=True,
                ),
                create_separator(),
                widget.WindowName(
                    # max_chars=10,
                    # scroll=True,
                    width=300,
                    format="{name}",
                    foreground=workspaceColor,
                ),
                create_separator(),
                widget.Spacer(),
                # Center - Date & Time
                widget.Clock(
                    format="%a,%b %-d",
                    foreground=foregroundColor,
                ),
                create_separator(),
                widget.Clock(format="%-l:%M %p", foreground=foregroundColor),
                widget.Spacer(),
                # Right modules - System Info
                widget.GenPollText(
                    func=lambda: (
                        " CAPS "
                        if "Caps Lock:   on"
                        in subprocess.run(
                            ["xset", "q"], capture_output=True, text=True
                        ).stdout
                        else ""
                    ),
                    padding=4,
                    update_interval=0.5,
                    # foreground=foregroundColor,
                    foreground=backgroundColor,
                ),
                widget.Systray(
                    icon_size=22,
                ),
                # create_separator(),
                # widget.CheckUpdates(
                #     distro="Fedora",
                #     no_update_string="",
                #     foreground=foregroundColor,
                #     fmt='{  }',
                # ),
                create_separator(),
                widget.TextBox(
                    text="󰕾",
                    foreground=foregroundColor,
                    mouse_callbacks={"Button1": lazy.spawn("pavucontrol")},
                ),
                widget.Volume(
                    mute_command="pamixer -t",
                    volume_up_command="pamixer -i 2",
                    volume_down_command="pamixer -d 2",
                    get_volume_command="pamixer --get-volume-human",
                    check_mute_command="pamixer --get-mute",
                    check_mute_string="true",
                    foreground=foregroundColor,
                ),
                create_separator(),
                widget.TextBox(text="󰻠", foreground=foregroundColor, padding=4),
                widget.CPU(
                    format="{load_percent:2.0f}%",
                    foreground=foregroundColor,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")
                    },
                ),
                create_separator(),
                widget.BatteryIcon(
                    foreground=foregroundColor,
                    scale=1.5,
                ),
                widget.Battery(
                    foreground=foregroundColor,
                    # charge_char=" ",
                    # discharge_char=" 󱐋",
                    # empty_char="",
                    # not_charging_char="",
                    format="{percent:2.0%} {hour:d}:{min:02d}hrs",
                    low_percentage=20,
                    notify_below=10,  # send notification below this %
                    notification_timeout= 0,
                ),
                create_separator(),
                widget.TextBox(
                    foreground=foregroundColor,
                    fmt=" ",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            os.path.expanduser("~/.config/qtile/scripts/power"),
                        )
                    },
                ),
                widget.Spacer(length=8),
            ],
            size=45,
            background=backgroundColor,
            margin=[0, 0, 0, 0],  # Remove margins for full-width bar
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]
