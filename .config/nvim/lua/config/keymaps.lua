-- LEADER KEY
-- set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- CMD SHORTCUTS
-- copy to and from with Shift-(y)
vim.keymap.set({ "n", "x" }, "<S-y>", '"+y', { desc = "copy to clipboard" })

-- paste to and from with Shift-(p)
vim.keymap.set({ "n", "x" }, "<S-p>", '"+p', { desc = "paste clipboard text" })

-- save current file quickly
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })

-- close current window quickly
vim.keymap.set("n", "<leader>x", "<C-w>c", { desc = "Close current window" })

-- stop highlighting after search
-- (H)ighlight (O)ff
vim.keymap.set("n", "<leader>ho", ":nohlsearch<CR>", { desc = "Removing highlighted text after a search" })

-- check spelling within file
vim.keymap.set("n", "<leader>cs", "<cmd>setlocal spell!<CR>", { desc = "[c]heck [s]pelling" })

-- easy window navigation with leader key
-- navigate to left, right, up, down (h,l,k,j)
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Navigate to left window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Navigate to right window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Navigate to window above" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Navigate to window below" })

-- resize windows with arrow keys easily
-- resize with Alt+Arrow Keys (upwards,downwards,left,right)
vim.keymap.set("n", "<A-k>", ":resize +2<CR>", { desc = "Resize horizontally to be bigger" })
vim.keymap.set("n", "<A-j>", ":resize -2<CR>", { desc = "Resize horizontally to be smaller" })
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { desc = "Resize vertically to be smaller" })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { desc = "Resize vertically to be bigger" })

-- navigate buffers easily with leader key
-- (N)ext and (P)revious
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Navigate to next buffer" })
vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { desc = "Navigate to previous buffer" })

-- visual mode tricks
-- remain in visual mode while identing to the right/left
vim.keymap.set("v", "<", "<gv", { desc = "Ident leftwards" })
vim.keymap.set("v", ">", ">gv", { desc = "Ident rightwards" })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "Move chunk downwards" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move chunk upwards" })

-- Continously move block of text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- easily navigate modes in terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Hardmode ON!!
-- from kickstart nvim
-- Disable arrow keys in normal mode with a styled message
vim.keymap.set("n", "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
vim.keymap.set("n", "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
vim.keymap.set("n", "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
vim.keymap.set("n", "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')

-- Disable arrow keys in insert mode with a styled message
-- vim.keymap.set("i", "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
-- vim.keymap.set("i", "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
-- vim.keymap.set("i", "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
-- vim.keymap.set("i", "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')
-- vim.api.nvim_set_keymap("i", "<Del>", "<C-o>" .. msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap("i", "<BS>", "<C-o>" .. msg, { noremap = true, silent = false })

-- some quick terminal movements
local Terminal = require("toggleterm.terminal").Terminal

-- open the python REPL quickly
local python = Terminal:new({ cmd = "python", hidden = true })

function PYTHON_TOGGLE()
	python:toggle()
end
vim.keymap.set("n", "<C-p>", "<cmd> :lua PYTHON_TOGGLE()<CR> <cmd>")
vim.keymap.set("i", "<C-p>", "<cmd> :lua PYTHON_TOGGLE()<CR> <cmd>")

-- open mysql
local mysql = Terminal:new({ cmd = "mysql -u root -p", hidden = true })

function MYSQL_TOGGLE()
	mysql:toggle()
end
vim.keymap.set("n", "<C-m>", "<cmd> :lua MYSQL_TOGGLE()<CR> <cmd>")
vim.keymap.set("i", "<C-m>", "<cmd> :lua MYSQL_TOGGLE()<CR> <cmd>")

-- toggle todo comments easily
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "[n]ext [t]odo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "[p]revious [t]odo comment" })
