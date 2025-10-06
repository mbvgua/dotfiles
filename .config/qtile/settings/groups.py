from libqtile.config import DropDown, Group, Key, Match, ScratchPad
from libqtile.lazy import lazy

from .keybindings import keys, mod


# =====================
# Groups/workspaces
# =====================
# group_names should remain 0-9 to match MOD+0-9 keybindings
# group_labels are how they appear in the bar. changes this freely

# matches=[Match(wm_class="Firefox")]
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_layouts = [
    "tile",
    "max",
    "matrix",
    "tile",
    "tile",
    "tile",
    "tile",
    "tile",
    "tile",
]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "MISC"]

# # Define scratchpads
# # Qtil crashes when uncommented. LOL
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
            layout=group_layouts[i],
            label=group_labels[i],
        )
    )

# open these apps in grp 2, where layout is always max
groups.append(
    Group(
        name=group_names[1],
        matches=[
            Match(wm_class="org.mozilla.firefox"),
            Match(wm_class="org.pwmt.zathura"),
            Match(wm_class="brave-browser"),
            Match(wm_class="teams-for-linux"),
        ],
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
