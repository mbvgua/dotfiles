-- set meta accessors for options
local vim = vim or {}
local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd

opt.mouse = "a"                         -- enable mouse mode:
cmd.colorscheme("monokai-pro")          -- set colorscheme

-- sync clipboard between os and neovim.
--  schedule the setting after `uienter` because it can increase startup-time.
vim.schedule(function() opt.clipboard = 'unnamedplus' end)

-- ui options
opt.number = true                       -- enable line numbers
opt.relativenumber = true               -- make the numbers relative!!
opt.signcolumn = "yes"                  -- reserve space in the gutter to show icons/errors
opt.cursorline = true                   -- highlight current line of cursor
opt.colorcolumn = "100"                 -- highlight column 100. dont cross
opt.scrolloff = 8                       -- keep 8 columns above/below cursor
opt.sidescrolloff = 8                   -- keep 8 columns left/right of cursor
opt.laststatus = 2                      -- show the status line
opt.showmode = false                    -- dont show current mode. already in statusline
opt.wrap = true                        -- dont wrap lines when opening splits,nvim-tree
opt.updatetime = 250                    -- allow for immediate feedback, on hover

-- indentation
opt.smartindent = true                  -- smart auto-indention
opt.autoindent = true                   -- keep identation from previous line
opt.copyindent = true                   -- copy indentation from previous line
opt.expandtab = true                    -- convert tabs to spaces
opt.tabstop = 4                         -- no. of spaces a tab counts for
opt.softtabstop = 4                     -- spaces applied when pressing tab
opt.shiftwidth = 4                      -- no. of spaces to use with indent(< & >)
opt.shiftround = true                   -- indent to multiples of shiftwidth
opt.showmatch = true                    -- briefly jump to matching bracket
opt.backspace = "indent,eol,start"      -- better backspace behaviour

-- searching
opt.hlsearch = true                     -- highlight search results
opt.incsearch = true                    -- highlight matches as you search
opt.ignorecase = true                   -- case-insensitive search
opt.smartcase = true                    -- case-sensitive if uppercase in search
opt.path:append("**")                   -- include subdirectories in search

-- whitespace
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "▸", precedes = "◂" }

-- code folding
-- source: https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"     -- use treesitter for code folding
opt.foldtext = ""                               -- you can see what is inside the fold
opt.foldlevel = 99
opt.foldlevelstart = 4                          -- top level is not folded. only nested folds
opt.foldnestmax = 5

-- command line completion
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

-- split behaviour
opt.splitright = true                   -- always put vertical splitsto the right
opt.splitbelow = true                   -- always put horizontal splits below

-- file handling
opt.autoread = true                     -- auto read changes done on files outside vim
opt.autowrite = true                    -- auto save chnages without asking

opt.swapfile = false                    -- dont create swap files
opt.backup = true                       -- allow for backup files
opt.undofile = true                     -- allow for persistent undo
-- [[
-- put swap,backup and undo files in a special location instead of current directory
-- thanks https://stackoverflow.com/a/15317146/30236232
-- and https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
-- ]]
USER = os.getenv("USER")
UNDODIR = "/home/" .. USER .. "/.config/nvim/undodir//"
BACKUPDIR = "/home/" .. USER .. "/.config/nvim/backupdir//"

-- if directories do not exist, make them
if fn.isdirectory(UNDODIR) == 0 then
	fn.mkdir(UNDODIR, "p", "0o700")
end

if fn.isdirectory(BACKUPDIR) == 0 then
	fn.mkdir(BACKUPDIR, "p", "0o700")
end

opt.undodir = UNDODIR                       -- save undo change in .vim directory
opt.backupdir = BACKUPDIR                   -- save backup change in .vim directory
