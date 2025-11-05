import os
import subprocess
import random

from libqtile import hook, widget, bar, qtile
from libqtile.command.base import expose_command
from libqtile.lazy import lazy
from libqtile.config import Screen

from .colours import *
from .keybindings import terminal
from .calender import toggle_calendar_popup

colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# =====================
# Screens
# =====================

widget_defaults = dict(
    font="JetBrains Mono Nerd Font Bold",
    fontsize=22,
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
                widget.Spacer(length=10),
                widget.CurrentLayout(foreground=foregroundColorTwo, padding=4),
                widget.TextBox(
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
                    mouse_callbacks={"Button1": lazy.function(toggle_calendar_popup)},
                ),
                create_separator(),
                widget.Clock(
                    format="%-l:%M %p",
                    foreground=foregroundColor,
                    mouse_callbacks={"Button1": lazy.function(toggle_calendar_popup)},
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
                # create_separator(),
                # widget.CheckUpdates(
                #     distro="Fedora",
                #     colour_have_updates = workspaceColor,
                #     colour_no_updates = foregroundColorTwo,
                #     display_format='{updates}'
                # ),
                create_separator(),
                widget.TextBox(
                    text="󰕾",
                    foreground=foregroundColorTwo,
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
                widget.TextBox(
                    text="󰻠",
                    foreground=foregroundColorTwo,
                ),
                widget.CPU(
                    format="{load_percent:2.0f}%",
                    foreground=foregroundColor,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(terminal + " -e bpytop")
                    },
                ),
                create_separator(),
                widget.BatteryIcon(
                    scale=1.5,
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            os.path.expanduser("~/.config/qtile/scripts/battery"),
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
                        "Button1": lambda: qtile.cmd_spawn(
                            os.path.expanduser("~/.config/qtile/scripts/battery"),
                        )
                    },
                ),
                create_separator(),
                widget.TextBox(
                    foreground=foregroundColor,
                    fmt="⏻",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            os.path.expanduser("~/.config/qtile/scripts/power"),
                        )
                    },
                ),
                widget.Spacer(length=10),
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
