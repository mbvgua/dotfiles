from libqtile import layout
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
    layout.MonadTall(**layout_theme),
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
