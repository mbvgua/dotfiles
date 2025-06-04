-- global options settings. see :help options

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- enable line numbers
vim.o.number = true

-- make the numbers relative!!
vim.wo.relativenumber = true

-- reserve space in the gutter to show icons/errors
vim.o.signcolumn = 'yes'

-- show row position of cursor
vim.opt.cursorline = true

-- elegantly display 1 column after crossing 'my textwidth=90'
vim.opt.colorcolumn='91'

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

-- keep identation from previous line
vim.opt.autoindent = true

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

-- NETRW SETTINGS
-- do not re-use directory listings
vim.g.netrw_fastbrowse = 0 

-- keep current directory same as browsing directory
vim.g.netrw_keepdir = 0

-- preview pane split vertically not horizontally
vim.g.netrw_preview = 1

-- absolute width of window with netwr present
vim.g.netrw_winsize = 25

-- tree-view
vim.g.netrw_liststyle = 3  

-- sort is affecting only: directories on the top, files below
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- hide dotfiles
vim.g.netrw_list_hide = [[',\(^\|\s\s\)\zs\.\S\+']]

-- hide dotfiles by default. toggle with gh
vim.g.netrw_hide = 1 

-- use the previous window to open file
vim.g.netrw_browse_split = 4

function ToggleVexplorer()
    if vim.t.expl_buf_num then
      local expl_win_num = vim.fn.bufwinnr(vim.t.expl_buf_num)
      local cur_win_num = vim.fn.winnr()
  
      if expl_win_num ~= -1 then
        while expl_win_num ~= cur_win_num do
          vim.cmd("wincmd w")
          cur_win_num = vim.fn.winnr()
        end
        vim.cmd("close")
      end
  
      vim.t.expl_buf_num = nil
    else
      vim.cmd("Vexplore!")
      vim.t.expl_buf_num = vim.fn.bufnr("%")
    end
end
  
-- toggle Netrw in normal mode with <leader>e
-- TODO: figure out how to modularize this and send it to the keymaps.lua
vim.keymap.set( "n", "<leader>e", ToggleVexplorer,
    { noremap = true,silent=true, desc="toggle [e]xplorer"}
)

-- BACKUP FILES SETTINGS
-- put swap,backup and undo files in a special location instead of current directory
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
