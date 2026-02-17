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
layout_theme: dict[str, int | str] = {
    "margin": 3,
    "border_width": 3,
    "border_focus": workspaceColor,
    "border_normal": foregroundColorTwo,
}

# less is more!
layouts = [
    layout.Tile(
        **layout_theme,
        add_after_last=True,
    ),
    layout.Max(**layout_theme),
    layout.Matrix(**layout_theme),
    # layout.MonadTall(**layout_theme),
    # layout.Columns(**layout_theme), # same as monadtall
    # Try more layouts by unleashing below layouts.
    # layout.Floating(**layout_theme), # dont know how to use this
    # layout.MonadWide(**layout_theme), # not very useful
    # layout.RatioTile(),
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
        # or `wn` thanks to my bash script
        *layout.Floating.default_float_rules,
        Match(wm_class="feh"),  # image viewer
        Match(wm_class="lxappearance"),  # lxappearance
        Match(wm_class="pavucontrol"),  # pavucontrol
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="org.gnome.Nautilus"),  # nautilus files
        Match(wm_class="thunar"),  # thunar files
        Match(wm_class="blueman-manager"),  # bluetooth settings
        Match(wm_class="gnome-calendar"),  # calender
        Match(wm_class="qbittorrent"),  # qbittorrent
        Match(title="pinentry"),  # GPG key password entry
    ],
)


# floating windows in fixed screen position
# sweet spot!! in centred position
@hook.subscribe.client_managed
def client_managed(client):
    floating_windows_suite: list[str] = [
        "feh",
        "pavucontrol",
        "org.gnome.Nautilus",
        "thunar",
        "qbittorrent",
    ]
    if client.get_wm_class()[0] in floating_windows_suite:
        client.set_size_floating(900, 750).set_position(300, 300)


auto_fullscreen: bool = True
focus_on_window_activation: str = "smart"
reconfigure_screens: bool = True
