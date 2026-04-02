import os
import subprocess

from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from libqtile import qtile

mod: str = "mod4"  # the TUX/SUPER/WINDOWS key
mod2: str = "mod1"  # the ALT key
shift: str = "shift"  # the left/right shift keys
space: str = "space"  # the space key
control: str = "control"

# my tools of choice
terminal: str = "alacritty"
browser: str = "~/helium-0.10.7.1-x86_64.AppImage"
files: str = "thunar"
teams: str = "teams-for-linux"


# =====================
# Useful resize functions
# =====================


def focus_left():
    """Focus window to the left, or cycle if floating"""

    def _focus_left(qtile):
        if qtile.current_layout.name == "floating" or qtile.current_window.floating:
            qtile.current_group.cmd_prev_window()
        else:
            qtile.current_layout.cmd_left()

    return _focus_left


def focus_right():
    """Focus window to the right, or cycle if floating"""

    def _focus_right(qtile):
        if qtile.current_layout.name == "floating" or qtile.current_window.floating:
            qtile.current_group.cmd_next_window()
        else:
            qtile.current_layout.cmd_right()

    return _focus_right


# =====================
# Useful notification functions
# =====================


def notify_restart():
    """Show restart notification"""

    def _notify_restart(qtile):
        subprocess.run(
            ["notify-send Qtile Restarting... -t 3000 -u normal"],
            shell=True,
        )

    return _notify_restart


# =====================
# Keybindings
# =====================

keys: list[Key | KeyChord] = [
    # =================
    # Qtile General
    # =================
    Key(
        [mod, shift],
        "r",
        lazy.function(notify_restart()),
        lazy.restart(),
        desc="[r]estart qtile",
    ),
    Key([mod, shift], "q", lazy.shutdown(), desc="shutdown [q]tile"),
    Key(
        [mod, mod2],
        "l",
        lazy.spawn("xfce4-screensaver-command -l"),
        desc="activate [l]ockscreen",
    ),
    Key(
        [mod],
        "delete",
        lazy.spawn(os.path.expanduser("~/.local/scripts/menu_power")),
        desc="activate poweroff menu",
    ),
    # =================
    # Groups(workspaces) specific
    # =================
    Key(
        [mod, mod2],
        "right",
        lazy.screen.next_group(),
        desc="move to group on the right",
    ),
    Key(
        [mod, mod2], "left", lazy.screen.prev_group(), desc="move to group on the left"
    ),
    # =================
    # Window actions
    # =================
    Key(
        [mod],
        "h",
        lazy.layout.shuffle_up(),
        lazy.layout.shuffle_left(),
        lazy.layout.swap_left(),
        desc="Move window up/left",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.shuffle_down(),
        lazy.layout.shuffle_right(),
        lazy.layout.swap_right(),
        desc="Move window down/right",
    ),
    # Resize windows
    Key(
        [mod, shift],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Decrease active window size",
    ),
    Key(
        [mod, shift],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Increase active window size",
    ),
    Key(
        [mod, shift],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Decrease window downwards",
    ),
    Key(
        [mod, shift],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Increase window upwards",
    ),
    Key([mod, shift], "n", lazy.layout.normalize(), desc="Reset all window [s]izes"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    # =================
    # Layout Control
    # =================
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod, shift],
        "space",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # =================
    # Focus Control
    # =================
    Key([mod], "n", lazy.layout.previous(), desc="Move window focus to previous window"),
    Key([mod], "p", lazy.layout.next(), desc="Move window focus to next window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # =================
    # Open My Tools
    # =================
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="launch [r]ofi"),
    KeyChord(
        [mod],
        "o",
        [
            Key([], "h", lazy.spawn(os.path.expanduser(browser)), desc="Open [h]elium"),
            Key([], "f", lazy.spawn(files), desc="Open [f]iles"),
            Key([], "t", lazy.spawn(teams), desc="Open [t]eams"),
            Key(
                [],
                "b",
                lazy.group["scratchpad"].dropdown_toggle("bt"),
                desc="open [b]luetooth scratchpad",
            ),
        ],
    ),
    # =================
    # Volume controls
    # =================
    Key(
        [mod],
        "m",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_volume mute")),
        desc="Mute/Unmute",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_volume up")),
        desc="Volume up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_volume down")),
        desc="Volume down",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_volume mute")),
        desc="Mute/Unmute",
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_volume mute")),
        desc="Mute/Unmute",
    ),
    # =================
    # LED Brightness controls
    # =================
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_brightness up")),
        desc="Brightness up",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(os.path.expanduser("~/.local/scripts/change_brightness down")),
        desc="Brightness down",
    ),
    # =================
    # Screenshots
    # =================
    Key(
        [mod2],
        "s",
        lazy.spawn("deepin-screenshot"),
        desc="[s]elect region screenshot",
    ),
    Key(
        [mod2],
        "space",
        lazy.spawn("deepin-screenshot -f"),
        desc="full screen screenshot",
    ),
    # =================
    # Scratchpads
    # =================
    Key(
        [mod],
        # using a since it was alacritty before hence got used to it
        # also will have nested tmux instance, thus navigating between
        # Ctrl+A and Tux+a is really convenient
        "a",
        lazy.group["scratchpad"].dropdown_toggle("terminal"),
        desc="open wezterm with tmux scratchpad",
    ),
    # toggle grayscale mode!! shiny lights bad...
    Key(
        [mod],
        "g",
        lazy.spawn(os.path.expanduser("~/.local/scripts/toggle_grayscale")),
        desc="toggle [g]rayscale mode systemwide",
    ),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )
