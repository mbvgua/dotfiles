-- global options settings. see :help options

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- enable line numbers
vim.o.number = true

-- make the numbers relative!!
vim.wo.relativenumber = true

-- reserve space in the gutter to show icons/errors
vim.o.signcolumn = "yes"

-- show row position of cursor
vim.opt.cursorline = true

-- elegantly display 1 column after crossing 'my textwidth=90'
vim.opt.colorcolumn = "91"

-- keep identation from previous line
vim.opt.autoindent = true

-- number of spaces that a tab will count for
vim.o.tabstop = 4

-- convert tabs to spaces
vim.opt.expandtab = true
vim.opt.shiftround = true

-- number of spaces to use with auto-indent(<< & >>)
-- if not set, tabstop value is used
vim.o.shiftwidth = 4

-- how many spaces are applied when pressing tab
vim.opt.softtabstop = 4

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- search $ highlighting
-- highlight text when doing a search
vim.o.hlsearch = true

-- incrementally highlight matching characters as you search
vim.o.incsearch = true

-- ignore caps while searching
vim.o.ignorecase = true

-- override ignorecase when searching for capital letters,
-- allowing you to search specifically for caps
vim.o.smartcase = true

-- set auto cold folding
vim.o.foldmethod = "indent"
vim.o.foldmethod = "syntax"

-- automatically re-read changes done on file.
-- no need to ask me everytime!!
vim.opt.autoread = true

-- save changes on file when closed abruptly.
-- :q! will still save changes made to file?! Not ideal
-- vim.opt.autowrite = true

-- allow backspace to delete over identations, EOL, e.t.c
vim.opt.backspace = "2"

-- ignore certain files that were unlikely to edit with vim
vim.opt.wildignore = {
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
vim.o.scrolloff = 8

-- min number of columns to keep on left/right of cursor
vim.o.sidescrolloff = 8

-- always show the status line
vim.opt.laststatus = 2

-- dont show current mode. already in statusline
vim.opt.showmode = false

-- always put new vertical window to the right always
vim.opt.splitright = true

-- always put new horizontal windows below
vim.opt.splitbelow = true

-- Highlight text for some time after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})

-- BACKUP FILES SETTINGS
-- put swap,backup and undo files in a special location instead of current directory
-- thanks https://stackoverflow.com/a/15317146/30236232
-- and https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
SWAPDIR = "/tmp/swap//"
BACKUPDIR = "/tmp/backup//"
UNDODIR = "/tmp/undo//"

-- if directories do not exist, make them
if vim.fn.isdirectory(SWAPDIR) == 0 then
	vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
	vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
	vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- enable swap, backup and persistent update
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		vim.o.backupext = extension
	end,
})

-- python specific files

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		vim.bo.tabstop = 4 -- TAB will be equal to 4 spaces
		vim.bo.softtabstop = 4 --insert/delete 4 spaces when hitting TAB/BACKSPACE
		vim.bo.shiftwidth = 4 -- operation >> & << will indent/unindent 4 columns
		vim.bo.textwidth = 79 -- lines longer than 79 chars are broken
		vim.bo.colorcolumn = "80" -- where right horizontal line margin will be showed
		vim.bo.expandtab = true -- inser spaces when hitting TAB
		vim.bo.autoindent = true -- align new line indentation with previous line
		vim.bo.fileformat = "unix" -- format all files to have unix base EOF
	end,
})
