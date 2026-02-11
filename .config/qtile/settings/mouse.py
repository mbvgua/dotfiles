from types import NoneType
from typing import Optional
from libqtile.config import Drag, Click
from libqtile.lazy import lazy

from .keybindings import mod

# removed mod key operation in floating windows
# now you simple press the buttons
# then my clicks were hijacked by the WM, reverted them back to default
mouse: list[Drag | Click] = [
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

dgroups_key_binder: Optional[NoneType] = None
dgroups_app_rules: list[str] = []  # type: list
follow_mouse_focus: bool = True
bring_front_click: bool = False
floats_kept_above: bool = True
cursor_warp: bool = False
