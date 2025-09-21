import os
import subprocess
import random
from typing import List

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import (
    Click,
    Drag,
    Group,
    Key,
    KeyChord,
    Match,
    Screen,
    ScratchPad,
    DropDown,
)
from libqtile.lazy import lazy

from colors import *

mod = "mod4"  # the TUX/SUPER/WINDOWS key
mod2 = "mod1"  # the ALT key
shift = "shift"  # the left/right shift keys
space = "space"  # the space key
control = "control"
WALLPAPER_DIR = os.path.expanduser("~/.config/qtile/wallpapers")
colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# my tools of choice
terminal = "wezterm"
browser = "firefox"
browser2 = "brave-browser"
teams = "teams-for-linux"


# =====================
# Useful functions
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
            ["notify-send", "Layout", display_name, "-t", "1500", "-u", "low"]
        )

    return _notify_layout


def notify_restart():
    """Show restart notification"""

    def _notify_restart(qtile):
        subprocess.run(
            ["notify-send", "Qtile", "Restarting...", "-t", "2000", "-u", "normal"]
        )

    return _notify_restart


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
# Keybindings
# =====================
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # =================
    # Qtile specific
    # =================
    Key([mod, control], "r", lazy.reload_config(), desc="[r]eload the config"),
    # Key(
    #     [mod, control],
    #     "r",
    #     lazy.function(notify_restart, lazy.restart()),
    #     desc="[r]estart qtile",
    # ),
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
        [control],
        "left",
        lazy.layout.grow_left(),
        lazy.function(resize_left()),
        desc="Grow window to the left",
    ),
    Key(
        [control],
        "right",
        lazy.function(resize_right()),
        desc="Grow window to the right",
    ),
    Key(
        [control],
        "down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Grow window down",
    ),
    Key(
        [control],
        "up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Grow window up",
    ),
    Key([control], "s", lazy.layout.normalize(), desc="Reset all window [s]izes"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
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
            Key(
                [],
                "r",
                lazy.spawn(
                    "rofi -show drun -modi drun -line-padding 4 -hide-scrollbar -show-icons -theme ~/.config/qtile/rofi/config.rasi"
                ),
                desc="launch [r]ofi",
            ),
            Key(
                [],
                "h",
                lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/help")),
                desc="[h]elp with keybindings mappink",
            ),
        ],
    ),
    # =================
    # Volume controls
    # =================
    Key(
        [mod],
        "Insert",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume up")),
        desc="Volume up",
    ),
    Key(
        [mod],
        "Delete",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/changevolume down")),
        desc="Volume down",
    ),
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
    # Brightness controls
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
        lazy.spawn("flameshot gui --path " + os.path.expanduser("~/Screenshots/")),
        desc="Screenshot (region select)",
    ),
    Key(
        [],
        "Print",
        lazy.spawn("flameshot full --path " + os.path.expanduser("~/Screenshots/")),
        desc="Screenshot (full screen)",
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn("flameshot gui --path " + os.path.expanduser("~/Screenshots/")),
        desc="Screenshot (region select alt)",
    ),
]

# Scratchpad keybindings
keys.extend(
    [
        Key(
            [mod, "shift"],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle(terminal),
        ),
        Key(
            [mod],
            "v",
            lazy.group["scratchpad"].dropdown_toggle("volume"),
            desc="Toggle volume scratchpad",
        ),
    ]
)

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

##################
# GROUPS/WORKSPACES
# group_names should remain 0-9 to match MOD+0-9 keybindings
# group_labels are how they appear in the bar. changes this freely
##################

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "MISC"]

# # Define scratchpads
# groups.append(
#     ScratchPad(
#         "scratchpad",
#         [
#             DropDown(
#                 "terminal",
#                 "wezterm",
#                 width=0.6,
#                 height=0.6,
#                 x=0.2,
#                 y=0.02,
#                 opacity=0.95,
#             ),
#             DropDown(
#                 "volume",
#                 "wezterm -c volume -e pulsemixer",
#                 width=0.5,
#                 height=0.5,
#                 x=0.25,
#                 y=0.02,
#                 opacity=0.95,
#             ),
#         ],
#     )
# )

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            label=group_labels[i],
        )
    )

for i in groups:
    # if i.name != "scratchpad":  # Skip scratchpad groups
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            # Key(
            #     [mod, "shift"],
            #     i.name,
            #     lazy.window.togroup(i.name, switch_group=False),
            #     desc=f"Switch to & move focused window to group {i.name}",
            # ),
            # Or, use below if you prefer not to switch to that group.
            # mod + shift + group number = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )


##################
# LAYOUT THEMES
##################
# some default layouts themes for each theme
layout_theme = {
    "margin": 5,
    "border_width": 3,
    "border_focus": colors[3],
    "border_normal": colors[1],
}

layouts = [
    layout.Tile(
        **layout_theme,
        add_after_last=True,
    ),
    layout.Max(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme),
    # layout.Columns(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]


##################
# SCREEN
##################


widget_defaults = dict(
    font="Roboto Mono Nerd Font",  # Match Polybar font
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


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="qimgv"),  # q image viewer
        Match(wm_class="lxappearance"),  # lxappearance
        Match(wm_class="pavucontrol"),  # pavucontrol
        Match(wm_class="Galculator"),  # calculator
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# a bash script to autostart programs on startup
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
