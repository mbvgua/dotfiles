import os
import subprocess
import random

from libqtile import hook, widget, bar, qtile
from libqtile.lazy import lazy
from libqtile.config import Screen

from .colours import *
from .keybindings import terminal

# gruvbox_dark monokai_pro
colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# =====================
# Wallpapers
# =====================

WALLPAPER_DIR: str = os.path.expanduser("~/.dotfiles/wallpapers")


# have random wallpaper on each reboot!
def set_random_wallpaper():
    wallpapers: list[str] = []
    for root, dirs, files in os.walk(WALLPAPER_DIR):
        for f in files:
            if f.lower().endswith((".jpg", ".jpeg", ".png")):
                wallpapers.append(os.path.join(root, f))
    if wallpapers:
        chosen: str = random.choice(wallpapers)
        subprocess.run(["feh", "--bg-fill", chosen])


@hook.subscribe.startup
def startup_wallpaper():
    set_random_wallpaper()


# =====================
# Screens
# =====================

widget_defaults: dict[str, str | int] = dict(
    font="JetBrains Mono Nerd Font Bold",
    fontsize=24,
    padding=3,
    background=backgroundColor,
    foreground=foregroundColor,
)

extension_defaults: dict[str, str | int] = widget_defaults.copy()


def create_separator():
    return widget.TextBox(
        text="|",
        foreground=foregroundColorTwo,  # disabled color
        padding=5,
        fontsize=19,
    )


screens: list[Screen] = [
    Screen(
        top=bar.Bar(
            [
                # Left modules - Layout & System Info
                widget.Spacer(length=10),
                widget.CurrentLayout(
                    custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons/")],
                    foreground=foregroundColorTwo,
                    scale=0.6,
                    mode="both",
                    icon_first=False,
                ),
                create_separator(),
                widget.GroupBox(
                    disable_drag=True,
                    use_mouse_wheel=False,
                    active=foregroundColor,
                    inactive=foregroundColorTwo,
                    highlight_method="line",
                    highlight_color=[backgroundColor, backgroundColor],
                    this_current_screen_border=workspaceColor,
                    this_screen_border=workspaceColor,
                    other_current_screen_border=foregroundColor,
                    other_screen_border=backgroundColor,
                    urgent_alert_method="text",
                    urgent_text=workspaceColor,
                    rounded=False,
                    hide_unused=True,  # hides unused workspaces
                ),
                create_separator(),
                widget.WindowName(
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
                widget.Clock(
                    format="%-l:%M %p",
                    foreground=foregroundColor,
                ),
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
                    foreground=foregroundColorTwo,
                ),
                widget.Systray(
                    icon_size=22,
                ),
                create_separator(),
                widget.TextBox(
                    text="󰕾",
                    foreground=foregroundColorTwo,
                ),
                # only mute/unmute from here. the toggle volume with keybinds
                widget.Volume(
                    # NOTE: uses amixer by default. not using that here
                    # still doent work?
                    get_volume_command="wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' | bc -l",
                    check_mute_command="wpctl get-volume @DEFAULT_AUDIO_SINK@",
                    check_mute_string="Volume: 0.00 [MUTED]",
                    foreground=foregroundColor,
                ),
                create_separator(),
                widget.TextBox(
                    text="󰻠",
                    foreground=foregroundColorTwo,
                ),
                widget.CPU(
                    format="{load_percent:2.0f}%",
                    foreground=foregroundColor,
                    mouse_callbacks={
                        "Button1": lambda: qtile.spawn(terminal + " -e btop")
                    },
                ),
                create_separator(),
                widget.BatteryIcon(
                    scale=1.5,
                    mouse_callbacks={
                        "Button1": lambda: qtile.spawn(
                            os.path.expanduser("~/.local/scripts/battery"),
                        )
                    },
                ),
                widget.Battery(
                    foreground=foregroundColor,
                    charging_foreground=workspaceColor,
                    # made irrelevant by xfce-power-manager
                    # format="{percent:2.0%} {hour:d}:{min:02d}hrs",
                    format="{percent:2.0%}",
                    low_percentage=0.2,  # fraction x%/100
                    notify_below=20,  # send notification below this %
                    notification_timeout=0,
                    mouse_callbacks={
                        "Button1": lambda: qtile.spawn(
                            os.path.expanduser("~/.local/scripts/battery"),
                        )
                    },
                ),
                create_separator(),
                widget.TextBox(
                    foreground=foregroundColor,
                    fmt="⏻ ",
                    mouse_callbacks={
                        "Button1": lambda: qtile.spawn(
                            os.path.expanduser("~/.local/.scripts/power"),
                        )
                    },
                ),
                widget.Spacer(length=10),
            ],
            size=45,
            background=backgroundColor,
            margin=[0, 0, 0, 0],  # Remove margins for full-width bar
        ),
        # # set wallpaper with qtile
        # wallpaper= os.path.expanduser("~/.config/qtile/wallpapers/hay.jpg"),
        # # mode -> fill, stretch, center
        # wallpaper_mode="fill",
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]
