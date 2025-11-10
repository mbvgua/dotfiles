from libqtile import layout, hook
from libqtile.config import Match

from .colours import *


colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)

# =====================
# Layouts
# =====================
# some default layouts themes for each theme
layout_theme = {
    "margin": 5,
    "border_width": 3,
    "border_focus": workspaceColor,
    "border_normal": foregroundColorTwo,
}

layouts = [
    layout.Tile(
        **layout_theme,
        add_after_last=True,
    ),
    layout.Max(**layout_theme),
    layout.Matrix(**layout_theme),
    # layout.MonadTall(**layout_theme),
    # layout.Floating(**layout_theme), # dont know how to use this
    # layout.Columns(**layout_theme), # same as monadtall
    # layout.MonadWide(**layout_theme), # not very useful
    # layout.RatioTile(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2), # dont know how to use this. confusing
    # layout.Bsp(**layout_theme), # wtf layout. only for clout
    # layout.TreeTab(**layout_theme), # refer to above
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]


# =====================
# Floating layouts
# =====================

# Drag floating layouts.
floating_layout = layout.Floating(
    **layout_theme,  # use custom theming
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="feh"),  # image viewer
        Match(wm_class="lxappearance"),  # lxappearance
        Match(wm_class="pavucontrol"),  # pavucontrol
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="org.gnome.Nautilus"),  # nautilus files
        Match(wm_class="blueman-manager"),  # bluetooth settings
        Match(wm_class="gnome-calendar"),  # calender
        Match(title="pinentry"),  # GPG key password entry
    ],
)


# change layout even for floating windows
# default retains them in floating
# https://github.com/qtile/qtile/discussions/3722
# @hook.subscribe.layout_change
# def _(layout, group):
#     for window in group.windows:
#         window.floating = False
# BUG: change layout of scratchpads to normal layout when I 
# switch the group. Very annoying!


# floating windows in fixed screen position
# sweet spot!! in centred position
@hook.subscribe.client_managed
def client_managed(client):
    floating_windows_suite = [
        "feh",
        "blueman-manager",
        "pavucontrol",
        "org.gnome.Nautilus",
    ]
    if client.get_wm_class()[0] in floating_windows_suite:
        client.set_size_floating(900, 750).set_position(300, 300)


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
