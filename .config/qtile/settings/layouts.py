import subprocess

from libqtile import layout
from libqtile.config import Screen, Match, Click

from .colours import *


colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo = (
    monokai_pro()
)


# =====================
# Useful layout functions
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
            ["notify-send Layout {display_name} -t 1500 -u low"],
            shell=True,
            # ["notify-send", "Layout", display_name, "-t", "1500", "-u", "low"]
        )

    return _notify_layout


def notify_restart():
    """Show restart notification"""

    def _notify_restart(qtile):
        subprocess.run(
            ["notify-send Qtile Restarting -t 2000 -u normal"],
            shell=True,
            # ["notify-send", "Qtile", "Restarting...", "-t", "2000", "-u", "normal"]
        )

    return _notify_restart


# =====================
# Layouts
# =====================
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
