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
terminal: str = "wezterm"
browser: str = "~/helium-0.9.2.1-x86_64.AppImage"
browser2: str = "qutebrowser"
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
    # Qtile specific
    # =================
    Key(
        [mod, control],
        "r",
        lazy.function(notify_restart()),
        # lazy.reload_config(), #-> not tinkering as much nowadays!
        lazy.restart(),
        desc="[r]estart qtile",
    ),
    Key([mod, control], "q", lazy.shutdown(), desc="shutdown [q]tile"),
    Key(
        [mod, mod2],
        "l",
        lazy.spawn("xfce4-screensaver-command -l"),
        desc="activate [l]ockscreen",
    ),
    Key(
        [mod],
        "delete",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/power")),
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
    # Resize windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, shift],
        "left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Decrease active window size",
    ),
    Key(
        [mod, shift],
        "right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Increase active window size",
    ),
    Key(
        [mod, shift],
        "down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Decrease window downwards",
    ),
    Key(
        [mod, shift],
        "up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Increase window upwards",
    ),
    Key([mod, shift], "n", lazy.layout.normalize(), desc="Reset all window [s]izes"),
    # not set to mod+q to match broswers. i.e ctrl+w to quit tab
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # =================
    # Layout Control
    # =================
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # =================
    # Focus Control
    # =================
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # =================
    # Open My Tools
    # =================
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch wezterm terminal"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="launch [r]ofi"),
    # TODO: how can i make this work with '?' like nvim
    # Key(
    #     [mod],
    #     "h",
    #     lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/help")),
    #     desc="[h]elp with keybindings mapping",
    # ),
    KeyChord(
        [mod],
        "o",
        [
            Key([], "h", lazy.spawn(os.path.expanduser(browser)), desc="Open [h]elium"),
            Key([], "q", lazy.spawn(browser2), desc="Open [q]utebrowser"),
            Key([], "f", lazy.spawn(files), desc="Open [f]iles"),
            Key([], "t", lazy.spawn(teams), desc="Open [t]eams"),
            Key(
                [],
                "b",
                lazy.group["scratchpad"].dropdown_toggle("bt"),
                desc="open [b]luetooth scratchpad",
            ),
            Key(
                [],
                "c",
                lazy.group["scratchpad"].dropdown_toggle("cal"),
                desc="open [c]alender scratchpad",
            ),
            Key(
                [],
                "d",
                lazy.group["scratchpad"].dropdown_toggle("diary"),
                desc="open [d]iary scratchpad",
            ),
        ],
    ),
    # =================
    # Volume controls
    # =================
    Key(
        [mod],
        "m",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume mute")),
        desc="Mute/Unmute",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume up")),
        desc="Volume up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume down")),
        desc="Volume down",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume mute")),
        desc="Mute/Unmute",
    ),
    # =================
    # LED Brightness controls
    # =================
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changebrightness up")),
        desc="Brightness up",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changebrightness down")),
        desc="Brightness down",
    ),
    # =================
    # Screenshots
    # =================
    Key(
        [mod2],
        "s",
        lazy.spawn("deepin-screenshot"),
        # lazy.spawn(os.path.expanduser("~/.config/qtile/sounds/screenshot_sound.mp3")),
        desc="[s]elect region screenshot",
    ),
    Key(
        [mod2],
        "space",
        lazy.spawn("deepin-screenshot -f"),
        # lazy.spawn(os.path.expanduser("~/.config/qtile/sounds/screenshot_sound.mp3")),
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
        lazy.group["scratchpad"].dropdown_toggle("wezterm"),
        desc="open wezterm with tmux scratchpad",
    ),
    # toggle grayscale mode!! shiny lights bad...
    Key(
        [mod],
        "g",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/toggle_grayscale")),
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
