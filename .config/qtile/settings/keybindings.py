import os
import subprocess

from libqtile.config import Key, KeyChord, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile import qtile

mod = "mod4"  # the TUX/SUPER/WINDOWS key
mod2 = "mod1"  # the ALT key
shift = "shift"  # the left/right shift keys
space = "space"  # the space key
control = "control"

# my tools of choice
terminal = "wezterm"
browser = "firefox"
browser2 = "brave-browser"
teams = "teams-for-linux"


# =====================
# Useful resize functions
# =====================


def toggle_float_center():
    """Toggle floating and center at 75% size"""

    def _toggle_float_center(qtile):
        window = qtile.current_window
        if window:
            was_floating = window.floating
            window.toggle_floating()
            if not was_floating and window.floating:
                # Only resize/center when going from tiled to floating
                screen = qtile.current_screen
                width = int(screen.width * 0.70)
                height = int(screen.height * 0.60)
                window.set_size_floating(width, height)
                window.center()

    return _toggle_float_center


def resize_left():
    """Resize window left - intuitive based on focus"""

    def _resize_left(qtile):
        layout = qtile.current_layout.name
        group = qtile.current_group

        # For BSP/Columns layouts with directional resize
        if layout in ["bsp", "columns"]:
            qtile.current_layout.cmd_grow_left()
        # For MonadTall/Tile - check if we're in main or stack area
        elif layout in ["monadtall", "monadwide", "tile", "ratiotile"]:
            # Get current window index
            current_idx = group.windows.index(qtile.current_window)
            # First window is usually main, so reverse the behavior
            if current_idx == 0:
                qtile.current_layout.cmd_shrink()
            else:
                qtile.current_layout.cmd_grow()
        else:
            # Default behavior for other layouts
            qtile.current_layout.cmd_shrink()

    return _resize_left


def resize_right():
    """Resize window right - intuitive based on focus"""

    def _resize_right(qtile):
        layout = qtile.current_layout.name
        group = qtile.current_group

        # For BSP/Columns layouts with directional resize
        if layout in ["bsp", "columns"]:
            qtile.current_layout.cmd_grow_right()
        # For MonadTall/Tile - check if we're in main or stack area
        elif layout in ["monadtall", "monadwide", "tile", "ratiotile"]:
            # Get current window index
            current_idx = group.windows.index(qtile.current_window)
            # First window is usually main, so reverse the behavior
            if current_idx == 0:
                qtile.current_layout.cmd_grow()
            else:
                qtile.current_layout.cmd_shrink()
        else:
            # Default behavior for other layouts
            qtile.current_layout.cmd_grow()

    return _resize_right


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
def notify_layout():
    """Show current layout in notification"""

    def _notify_layout(qtile):
        layout_name = qtile.current_group.layout.name
        layout_map = {
            "tile": "Tile",
            "max": "Maximized",
            "matrix": "Matrix",
            "monadtall": "Monad Tall",
            "columns": "Columns",
            "bsp": "BSP",
            "treetab": "Tree Tab",
            "plasma": "Plasma",
            "floating": "Floating",
            "spiral": "Spiral",
            "ratiotile": "Ratio Tile",
            "monadwide": "Monad Wide",
            "verticaltile": "Vertical Tile",
            "stack": "Stack",
            "zoomy": "Zoomy",
        }
        display_name = layout_map.get(layout_name, layout_name.title())
        subprocess.run(
            [f"notify-send Layout {display_name} -t 1500 -u low"],
            shell=True,
        )

    return _notify_layout


def notify_restart():
    """Show restart notification"""

    def _notify_restart(qtile):
        subprocess.run(
            ["notify-send Qtile Restarting... -t 2000 -u normal"],
            shell=True,
        )

    return _notify_restart


# =====================
# Keybindings
# =====================

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # =================
    # Qtile specific
    # =================
    # Key([mod, control], "r", lazy.reload_config(), desc="[r]eload the config"),
    Key(
        [mod, control],
        "r",
        lazy.function(notify_restart()),
        lazy.restart(),
        desc="[r]estart qtile",
    ),
    Key([mod, control], "q", lazy.shutdown(), desc="shutdown [q]tile"),
    # =================
    # Groups(workspaces) specific
    # =================
    Key([mod], "n", lazy.screen.next_group(), desc="move to group on the right"),
    Key([mod], "p", lazy.screen.prev_group(), desc="move to group on the left"),
    # imitate normal gnome de
    Key(
        [mod, mod2],
        "right",
        lazy.screen.next_group(),
        desc="move to group on the right",
    ),
    Key(
        [mod, mod2], "left", lazy.screen.prev_group(), desc="move to group on the left"
    ),
    Key([mod2], "Tab", lazy.screen.toggle_group(), desc="move to last visited group"),
    # =================
    # Window actions
    # =================
    Key(
        [mod, shift],
        "h",
        lazy.layout.shuffle_up(),
        lazy.layout.shuffle_left(),
        desc="Move window up/left",
    ),
    Key(
        [mod, shift],
        "l",
        lazy.layout.shuffle_down(),
        lazy.layout.shuffle_right(),
        desc="Move window down/right",
    ),
    # Resize windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [shift],
        "left",
        lazy.layout.grow_left(),
        lazy.function(resize_left()),
        desc="Grow window to the left",
    ),
    Key(
        [shift],
        "right",
        lazy.function(resize_right()),
        desc="Grow window to the right",
    ),
    Key(
        [shift],
        "down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Grow window down",
    ),
    Key(
        [shift],
        "up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Grow window up",
    ),
    Key([shift], "s", lazy.layout.normalize(), desc="Reset all window [s]izes"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # # Toggle between split and unsplit sides of stack.
    # # Split = all windows displayed
    # # Unsplit = 1 window displayed, like Max layout, but still with
    # # multiple stack panes
    # Key( [mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack",),
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
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
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
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    KeyChord(
        [mod],
        "o",
        [
            Key([], "t", lazy.spawn(terminal), desc="Open [w]ezterm"),
            Key([], "f", lazy.spawn(browser), desc="Open [f]irefox"),
            Key([], "b", lazy.spawn(browser2), desc="Open [b]rave Browser"),
            Key([], "s", lazy.spawn(teams), desc="Open [t]eams"),
            Key( [], "r", lazy.spawn("rofi -show drun"), desc="launch [r]ofi",),
            Key(
                [],
                "h",
                lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/help")),
                desc="[h]elp with keybindings mapping",
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
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +10"), desc="Brightness up"),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -10"),
        desc="Brightness down",
    ),
    # =================
    # Screenshots
    # =================
    Key(
        [mod],
        "Print",
        lazy.spawn(
            "flameshot gui --path " + os.path.expanduser("~/Pictures/Screenshots/")
        ),
        desc="Screenshot (region select)",
    ),
    # current device doesnt ahve this key
    # Key(
    #     [],
    #     "Print",
    #     lazy.spawn(
    #         "flameshot full --path " + os.path.expanduser("~/Pictures/Screenshots/")
    #     ),
    #     desc="Screenshot (full screen)",
    # ),
    Key(
        [mod, shift],
        "s",
        lazy.spawn(
            "flameshot gui --path " + os.path.expanduser("~/Pictures/Screenshots/")
        ),
        desc="Screenshot (region select alt)",
    ),
]

# # Scratchpad keybindings
# # Unable to add the group in groups.py wont work
# keys.extend(
#     [
#         Key(
#             [mod, "shift"],
#             "Return",
#             lazy.group["scratchpad"].dropdown_toggle(terminal),
#         ),
#         Key(
#             [mod],
#             "v",
#             lazy.group["scratchpad"].dropdown_toggle("volume"),
#             desc="Toggle volume scratchpad",
#         ),
#     ]
# )


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
