-- LEADER KEY
-- set the leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- CMD SHORTCUTS
-- copy to and from with Shift-(y)
vim.keymap.set(
    {'n','x'},
    '<S-y>','"+y',
    {desc='copy to clipboard'}
)

-- paste to and from with Shift-(p)
vim.keymap.set(
    {'n','x'},
    '<S-p>','"+p',
    {desc='paste clipboard text'}
)

-- save current file quickly
vim.keymap.set(
    'n',
    '<leader>w','<cmd>write<cr>',
    {desc = 'Save file'}
)

-- close current window quickly
vim.keymap.set(
    'n',
    '<leader>c','<C-w>c',
    {desc='Close current window'}
)

-- close all file and exit vim
vim.keymap.set(
    'n', 
    '<leader>q', 
    '<cmd>quitall<cr>', 
    {desc = 'Exit vim'}
)

-- stop highlighting after search
-- (H)ighlight (O)ff
vim.keymap.set(
    'n',
    '<leader>ho',
    ':nohlsearch<CR>',
    {desc='Removing highlighted text after a search'}
)

-- easy window navigation with leader key
-- navigate to left
vim.keymap.set(
    'n','<leader>h','<C-w>h',{desc='Navigate to left window'}
)

-- navigate to right
vim.keymap.set(
    'n','<leader>l','<C-w>l',{desc='Navigate to right window'}
)

-- navigate up
vim.keymap.set(
    'n','<leader>k','<C-w>k',{desc='Navigate to window above'}
)

-- navigate down
vim.keymap.set(
    'n','<leader>j','<C-w>j',{desc='Navigate to window below'}
)
  
-- resize windows with arrow keys easily
-- resize upwards
vim.keymap.set(
    'n', '<C-Up>', ':resize +2<CR>'
)

-- resize downwards
vim.keymap.set(
    'n', '<C-Down>', ':resize -2<CR>'
)

-- resize to the left
vim.keymap.set(
    'n', '<C-Left>', ':vertical resize -2<CR>'
)

-- resize to the right
vim.keymap.set(
    'n', '<C-Right>', ':vertical resize +2<CR>'
)

-- navigate buffers easily with leader key
-- (N)ext and (P)revious
vim.keymap.set(
    'n', '<leader>n', ':bnext<CR>'
)

vim.keymap.set(
    'n', '<leader>p', ':bprevious<CR>'
) 

-- visual mode tricks
-- remain in visual mode while identing to the right/left
vim.keymap.set(
    'v', '<', '<gv'
)

vim.keymap.set(
    'v', '>', '>gv'
)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")

-- Continously move block of text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")
