from libqtile import bar, layout, qtile, widget
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

import colors

mod = "mod4"  # the TUX/SUPER/WINDOWS key
mod2 = "mod1"  # the ALT key
shift = "shift"  # the left/right shift keys
space = "space"  # the space key
control = "control"
colors = colors.GruvboxDark

# my tools of choice
terminal = "wezterm"
browser = "firefox"
browser2 = "brave-browser"
teams = "teams-for-linux"


##################
# KEYBINDINGS
##################

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # =================
    # Qtile specific
    # =================
    Key([mod, "control"], "r", lazy.reload_config(), desc="[r]eload the config"),
    # Key([mod, "control"], "r", lazy.restart(), desc="[r]estart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
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
    Key([mod, shift], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key(
        [mod, shift],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, shift], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, shift], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([control], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([control], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key(
        [control],
        "down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        desc="Grow window down",
    ),
    Key(
        [control],
        "up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
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
        ],
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

##################
# GROUPS/WORKSPACES
# group_names should remain 0-9 to match MOD+0-9 keybindings
# group_labels are how they appear in the bar. changes this freely
##################

groups = [Group(i) for i in "123456789"]
# group_names = "123456789"
# group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
#  group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX", "MISC"]

for i in groups:
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
    "border_width": 2,
    "border_focus": colors[8],
    "border_normal": colors[0],
}

layouts = [
    layout.Tile(
        **layout_theme,
        add_after_last=True,
    ),
    layout.Max(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
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
widget_defaults = dict(font="sans", fontsize=12, padding=3, background=colors[2])

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(mode="both", icon_first=False),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
                widget.CPUGraph(),
                widget.Battery(),
                widget.BatteryIcon(),
            ],
            34,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
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
