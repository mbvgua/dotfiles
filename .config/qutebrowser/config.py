from pathlib import Path
from urllib.parse import urlparse

## to get generation od=f this file, use:
## config-write-py --defaults in qutebrowser

home = str(Path.home())
config = config  # type: ConfigAPI
c = c  # type: ConfigContainer

## remove configs set via the GUI
config.load_autoconfig(True)

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
## Type: Dict
c.aliases = {
    "w": "session-save",
    "q": "close",
    "qa": "quit",
    "wq": "quit --save",
    "wqa": "quit --save",
}

## always restore open sites when qutebrowser is reopened
c.auto_save.session = True

## Which categories to show (in which order) in the :open completion.
c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

# Search engines which can be used via the address bar
# NOTE: none of the other work, only ddg
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    ## use inbuilt ddg bangs instead: https://duckduckgo.com/bangs
    # !r    -> reddit
    # !yt   -> youtube
    # !w    -> wikipedia
    # !gh   -> github
    # !g    -> google
    # !di   -> dictionary
    # !g    -> google
    # !m    -> google maps
    ## techstuff
    # !py   -> official python docs
    # !a2   -> aletrnative 2 website
    # !archwiki -> archwiki
    # !dockerhub    -> dockerhub
    "cb": "https://codeberg.org/explore/users?q={}",
}

## Require a confirmation before quitting the application.
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
c.confirm_quit = ["multiple-tabs", "downloads"]

## Automatically start playing `<video>` elements.
c.content.autoplay = False

## Display PDF files via PDF.js in the browser without showing a download
## prompt. Note that the files can still be downloaded by clicking the
## download button in the pdf.js viewer. With this set to `false`, the
## `:prompt-open-download --pdfjs` command (bound to `<Ctrl-p>` by
## default) can be used in the download prompt.
## Type: Bool
c.content.pdfjs = True

## Directory to save downloads to. If unset, a sensible OS-specific
c.downloads.location.directory = "~/Downloads/"

## Editor (and arguments) to use for the `edit-*` commands. The following
## placeholders are defined:  * `{file}`: Filename of the file to be
## edited. * `{line}`: Line in which the caret is found in the text. *
## `{column}`: Column in which the caret is found in the text. *
## `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
## Same as `{column}`, but starting from index 0.
## Type: ShellCommand
c.editor.command = ["nvim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

## set colorscheme
config.source("./monokai.py")
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("colors.webpage.bg", "black")
config.set("colors.webpage.darkmode.enabled", True)

## Default font families to use. Whenever "default_family" is used in a
c.fonts.default_family = ["Source Code Pro"]

## Default font size to use. Whenever "default_size" is used in a font
## setting, it's replaced with the size listed here
c.fonts.default_size = "13pt"

## List of widgets displayed in the statusbar.
## Type: List of StatusbarWidget
## Valid values:
##   - url: Current page URL.
##   - scroll: Percentage of the current page position like `10%`.
##   - scroll_raw: Raw percentage of the current page position like `10`.
##   - history: Display an arrow when possible to go back/forward in history.
##   - search_match: A match count when searching, e.g. `Match [2/10]`.
##   - tabs: Current active tab, e.g. `2`.
##   - keypress: Display pressed keys when composing a vi command.
##   - progress: Progress bar for the current page loading.
##   - text:foo: Display the static text after the colon, `foo` in the example.
##   - clock: Display current time. The format can be changed by adding a format string via `clock:...`. For supported format strings, see https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes[the Python datetime documentation].
c.statusbar.widgets = [
    "keypress",
    "search_match",
    "url",
    "scroll",
    "history",
    "tabs",
    "progress",
]

## Padding (in pixels) for tab indicators.
## Type: Padding
c.tabs.indicator.padding = {"top": 3, "bottom": 3, "left": 0, "right": 4}

## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
c.tabs.show = "multiple"

## Default zoom level.
## Type: Perc
c.zoom.default = "110%"

## Available zoom levels.
## Type: List of Perc
# c.zoom.levels = ['25%', '33%', '50%', '67%', '75%', '90%', '100%', '110%', '125%', '150%', '175%', '200%', '250%', '300%', '400%', '500%']

# paywall bypassing
config.bind(
    "<Space>bs",
    'spawn bash -c "echo {url} >> ~/.dotfiles/.config/qutebrowser/js_blacklist.txt"',
)
with open(f"{home}/.config/qutebrowser/js_blacklist.txt") as f:
    js_blacklist = f.read().splitlines()

for item in js_blacklist:
    domain = urlparse(item).netloc
    config.set("content.javascript.enabled", False, f"*://{domain}/*")
    config.set("content.javascript.enabled", False, f"*://www.{domain}/*")

## Bindings for normal mode
config.bind("<Space>m", "hint links spawn mpv {hint-url}")
config.bind(
    "<Space>w",
    "hint links spawn wezterm -e yt-dlp -f 'bestvideo+bestaudio/best' {hint-url} -o '~/Videos/Youtube/%(title)s.%(ext)s'",
)
config.bind("<Space>b", "bookmark-list --jump")
config.bind("<Space>h", "history")
config.bind("<Space>bl", "bookmark-list")
config.bind("<F12>", "devtools")
# config.bind('<Ctrl-Alt-p>', 'print')
# config.bind('<Ctrl-B>', 'scroll-page 0 -1')
# config.bind('<Ctrl-F>', 'scroll-page 0 1')
# config.bind('<Ctrl-D>', 'scroll-page 0 0.5')
# config.bind('<Ctrl-U>', 'scroll-page 0 -0.5')
# config.bind('<Ctrl-Tab>', 'tab-focus last')
# config.bind('<Ctrl-h>', 'home')
# config.bind('<Ctrl-p>', 'tab-pin')
# config.bind('M', 'bookmark-add')
# config.bind('[[', 'navigate prev')
# config.bind(']]', 'navigate next')
# config.bind('g$', 'tab-focus -1')
# config.bind('g0', 'tab-focus 1')
# config.bind('gB', 'cmd-set-text -s :bookmark-load -t')
# config.bind('gC', 'tab-clone')
# config.bind('gD', 'tab-give')
# config.bind('gJ', 'tab-move +')
# config.bind('gK', 'tab-move -')
# config.bind('gO', 'cmd-set-text :open -t -r {url:pretty}')
# config.bind('gU', 'navigate up -t')
# config.bind('g^', 'tab-focus 1')
# config.bind('gd', 'download')
# config.bind('m', 'quickmark-save')
# config.bind('r', 'reload')
# config.bind('u', 'undo')
# config.bind('yy', 'yank')
# config.bind('{{', 'navigate prev -t')
# config.bind('}}', 'navigate next -t')

## Bindings for caret/VISUAL mode
config.bind("^", "move-to-start-of-line", mode="caret")

## Bindings for command mode
config.bind("<Ctrl-n>", "command-history-next", mode="command")
config.bind("<Ctrl-p>", "command-history-prev", mode="command")
config.bind("<Ctrl-j>", "completion-item-focus --history next", mode="command")
config.bind("<Ctrl-k>", "completion-item-focus --history prev", mode="command")
