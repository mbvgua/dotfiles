import os
import subprocess
import random

from libqtile import hook, widget, bar
from libqtile.lazy import lazy
from libqtile.config import Screen

from .colours import *

colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# =====================
# Wallpapers
# =====================

WALLPAPER_DIR = os.path.expanduser("~/.config/qtile/wallpapers")


def set_random_wallpaper():
    wallpapers = []
    for root, dirs, files in os.walk(WALLPAPER_DIR):
        for f in files:
            if f.lower().endswith((".jpg", ".jpeg", ".png")):
                wallpapers.append(os.path.join(root, f))
    if wallpapers:
        chosen = random.choice(wallpapers)
        subprocess.run(["feh", "--bg-fill", chosen])


@hook.subscribe.startup_once
def startup_wallpaper():
    set_random_wallpaper()


@hook.subscribe.setgroup
def change_wallpaper():
    set_random_wallpaper()


# =====================
# Screens
# =====================

widget_defaults = dict(
    font="Roboto Mono Nerd Font",
    fontsize=21,
    padding=3,
    background=backgroundColor,
    foreground=foregroundColor,
)

extension_defaults = widget_defaults.copy()


# Custom separator to match Polybar
def create_separator():
    return widget.TextBox(
        text="|",
        foreground=foregroundColorTwo,  # disabled color
        padding=8,
        fontsize=14,
    )


screens = [
    Screen(
        top=bar.Bar(
            [
                # Left modules - Layout & System Info
                widget.Spacer(length=8),
                widget.CurrentLayoutIcon(
                    custom_icon_paths=[
                        os.path.expanduser("~/.config/qtile/icons/layouts")
                    ],
                    foreground=colors[6][0],
                    scale=0.6,
                    padding=4,
                    mode="both",
                    icon_first=True,
                ),
                create_separator(),
                widget.GroupBox(
                    disable_drag=True,
                    use_mouse_wheel=False,
                    active=foregroundColor,
                    inactive=foregroundColorTwo,
                    highlight_method="line",
                    highlight_color=[backgroundColor, backgroundColor],
                    this_current_screen_border=colors[6][0],
                    this_screen_border=colors[1][0],
                    other_current_screen_border=colors[1][0],
                    other_screen_border=backgroundColor,
                    urgent_alert_method="text",
                    urgent_text=colors[9][0],
                    rounded=False,
                    margin_x=0,
                    margin_y=2,
                    padding_x=8,
                    padding_y=4,
                    borderwidth=3,
                    # hide_unused=True,
                ),
                create_separator(),
                # widget.WindowName(foreground=colors[6], padding=8, max_chars=40),
                # create_separator(),
                widget.Prompt(
                    font="Ubuntu Mono", fontsize=17, foreground=colors[1], padding=8
                ),
                create_separator(),
                widget.Spacer(),
                # Center - Date & Time
                widget.Clock(
                    format="%a, %b %-d", foreground=foregroundColorTwo, padding=4
                ),
                create_separator(),
                widget.Clock(format="%-l:%M %p", foreground=foregroundColor, padding=4),
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
                    update_interval=0.5,
                    padding=4,
                    foreground=foregroundColor,
                    # foreground=colors[9][0],
                ),
                # widget.CapsNumLockIndicator(),
                widget.Systray(
                    padding=4,
                ),
                create_separator(),
                widget.TextBox(
                    text="󰕾",
                    foreground=colors[6][0],
                    padding=4,
                    mouse_callbacks={"Button1": lazy.spawn("pavucontrol")},
                ),
                widget.Volume(
                    fmt="{}",
                    mute_command="pamixer -t",
                    volume_up_command="pamixer -i 2",
                    volume_down_command="pamixer -d 2",
                    get_volume_command="pamixer --get-volume-human",
                    check_mute_command="pamixer --get-mute",
                    check_mute_string="true",
                    foreground=foregroundColor,
                    padding=4,
                ),
                create_separator(),
                widget.TextBox(text="󰍛", foreground=colors[6][0], padding=2),
                widget.Memory(
                    format="{MemPercent:2.0f}%", foreground=foregroundColor, padding=4
                ),
                create_separator(),
                widget.TextBox(text="󰻠", foreground=colors[6][0], padding=4),
                widget.CPU(
                    format="{load_percent:2.0f}%", foreground=foregroundColor, padding=4
                ),
                create_separator(),
                widget.TextBox(text="󰋊", foreground=colors[6][0], padding=4),
                widget.DF(
                    visible_on_warn=False,
                    format="{r:.0f}%",
                    partition="/",
                    foreground=foregroundColor,
                    padding=2,
                ),
                widget.Spacer(length=8),
            ],
            size=37,
            background=backgroundColor,
            margin=[0, 0, 0, 0],  # Remove margins for full-width bar
            # border_width=[0, 0, 0, 0],  # No borders to match Polybar
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]
