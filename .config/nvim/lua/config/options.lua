-- global options settings. see :help options

-- number of spaces that a tab will count for
vim.o.tabstop = 2 

-- number of spaces to use for after each auto-indent 
-- if not set, tabstop value is used
vim.o.shiftwidth = 2

-- use spaces as tabs
vim.opt.shiftround = true
vim.opt.expandtab = true

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
vim.o.foldmethod = 'indent'
vim.o.foldmethod = 'syntax'
vim.o.foldlevel = 3
vim.o.foldlevelstart = 3

-- automatically re-read changes done on file.
-- no need to ask me everytime!!
vim.opt.autoread = true

-- save changes on file when closed abruptly.
vim.opt.autowrite = true

-- allow backspace to delete over identations, EOL, e.t.c
vim.opt.backspace = '2'

-- ignore certain files that were unlikely to edit with vim
vim.opt.wildignore = {
    '*.o',
    '*.docx',
    '*.jpg',
    '*.png',
    '*.gif',
    '*.pdf',
    '*.pyc',
    '*.exe',
    '*.flv',
    '*.img',
    '*.xlsx',
    '*.xls'
}

-- put swap,backup and undo files in a special location
-- instead of the current working directory
-- thanks https://stackoverflow.com/a/15317146/30236232
-- and https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
SWAPDIR = '/tmp/swap//'
BACKUPDIR = '/tmp/backup//'
UNDODIR = '/tmp/undo//'

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
