from libqtile.config import DropDown, Group, Key, Match, ScratchPad
from libqtile.lazy import lazy

from .keybindings import keys, mod, terminal, terminal2


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


for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i],
            label=group_labels[i],
        )
    )

# open these apps in grp 2, where layout is always max
# groups.appends -> only takes one items
# gropus.extends -> takes multiple items
groups.append(
    Group(
        name=group_names[1],
        matches=[
            Match(wm_class="org.mozilla.firefox"),
            Match(wm_class="org.pwmt.zathura"),
            Match(wm_class="brave-browser"),
            Match(wm_class="teams-for-linux"),
            # Match(wm_class="qutebrowser"),
        ],
    ),
)

# define scratchpads
groups.append(
    ScratchPad(
        "scratchpad",
        [
            # normal terminal scratchpad
            DropDown(
                "sp",
                terminal,
                match=Match(wm_class="org.wezfurlong.wezterm"),
                on_focus_lost_hide=False,
                width=0.6,
                height=0.6,
                x=0.2,
                y=0.02,
                opacity=0.95,
            ),
            # alacritty terminla with tmux
            DropDown(
                "tmux",
                f"{terminal2} -e tmux",
                match=Match(wm_class="Alacritty"),
                on_focus_lost_hide=False,
                width=0.6,
                height=0.6,
                x=0.2,
                y=0.02,
                opacity=0.95,
            ),
            # simple notes scratchpad
            DropDown(
                "diary",
                f"{terminal} -e nvim notes.md",
                match=Match(wm_class="org.wezfurlong.wezterm"),
                on_focus_lost_hide=False,
                width=0.6,
                height=0.7,
                x=0.2,
                y=0.02,
                opacity=0.95,
            ),
            # bluetooth UI
            DropDown(
                "bt",
                "blueman-manager",
                match=Match(wm_class="blueman-manager"),
                on_focus_lost_hide=True,
                width=0.6,
                height=0.7,
                x=0.2,
                y=0.02,
                opacity=1,
            ),
        ],
    ),
)


for i in groups:
    if i.name != "scratchpad":  # Skip scratchpad groups
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
