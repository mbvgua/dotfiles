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

-- min number of columns to keep above & below cursor line
vim.o.scrolloff = 7

-- min number of columns to keep on left/right of cursor
vim.o.sidescrolloff = 8

-- always show the status line
vim.opt.laststatus = 2

-- always put new vertical window to the right always
vim.opt.splitright = true

-- always put new horizontal windows below
vim.opt.splitbelow = true

-- folds!!!On indent and syntax
vim.opt.foldmethod = 'indent'
vim.opt.foldmethod = 'syntax'

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
-- TODO: figure out how to modulariza this and send it to the keymaps.lua
vim.keymap.set(
    "n", 
    "<leader>e", 
    ToggleVexplorer, 
    { noremap = true, silent = true }
)
