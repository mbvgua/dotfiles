local vim = vim or {}

-- meta accessor for options
local o = vim.o
local opt = vim.opt
local fn = vim.fn
local wo = vim.wo

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = "a"

-- enable line numbers
o.number = true

-- make the numbers relative!!
wo.relativenumber = true

-- reserve space in the gutter to show icons/errors
o.signcolumn = "yes"

-- show row position of cursor
opt.cursorline = true

-- elegantly display 1 column after crossing 'my textwidth=90'
opt.colorcolumn = "91"

-- keep identation from previous line
opt.autoindent = true

-- convert tabs to spaces
opt.expandtab = true
opt.shiftround = true

-- number of spaces that a tab will count for
o.tabstop = 4

-- number of spaces to use with auto-indent(<< & >>)
o.shiftwidth = 4

-- how many spaces are applied when pressing tab
opt.softtabstop = 4

-- how whitespace characters are displayed
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- highlight text when doing a search
o.hlsearch = true

-- incrementally highlight matching characters as you search
o.incsearch = true

-- ignore caps while searching
o.ignorecase = true

-- override ignorecase when searching for capital letters,
-- allowing you to search specifically for caps
o.smartcase = true

-- allow code folding with tree sitter
-- gotten from: https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for code folding
opt.foldtext = "" -- you can see what is inside the fold
opt.foldlevel = 99
opt.foldlevelstart = 4 --top level is not folded. only nested folds
opt.foldnestmax = 5

-- automatically re-read changes done on file.
-- no need to ask me everytime!!
opt.autoread = true

-- allow backspace to delete over identations, EOL, e.t.c
opt.backspace = "2"

-- ignore certain files that were unlikely to edit with vim
opt.wildignore = {
	"*.o",
	"*.docx",
	"*.jpg",
	"*.png",
	"*.gif",
	"*.pdf",
	"*.pyc",
	"*.exe",
	"*.flv",
	"*.img",
	"*.xlsx",
	"*.xls",
}

-- min number of columns to keep above & below cursor line
o.scrolloff = 8

-- min number of columns to keep on left/right of cursor
o.sidescrolloff = 8

-- always show the status line
opt.laststatus = 2

-- dont show current mode. already in statusline
opt.showmode = false

-- always put new vertical window to the right always
opt.splitright = true

-- always put new horizontal windows below
opt.splitbelow = true

-- BACKUP FILES SETTINGS
-- put swap,backup and undo files in a special location instead of current directory
-- thanks https://stackoverflow.com/a/15317146/30236232
-- and https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
SWAPDIR = "/tmp/swap//"
BACKUPDIR = "/tmp/backup//"
UNDODIR = "/tmp/undo//"

-- if directories do not exist, make them
if fn.isdirectory(SWAPDIR) == 0 then
	fn.mkdir(SWAPDIR, "p", "0o700")
end

if fn.isdirectory(BACKUPDIR) == 0 then
	fn.mkdir(BACKUPDIR, "p", "0o700")
end

if fn.isdirectory(UNDODIR) == 0 then
	fn.mkdir(UNDODIR, "p", "0o700")
end

-- enable swap, backup and persistent update
opt.swapfile = true
opt.backup = true
opt.undofile = true

opt.directory = SWAPDIR
opt.backupdir = BACKUPDIR
opt.undodir = UNDODIR
