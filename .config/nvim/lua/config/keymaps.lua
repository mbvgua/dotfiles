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

-- close all file and exit vim
vim.keymap.set("n", "<leader>q", "<cmd>quitall<cr>", { desc = "Exit vim" })

-- stop highlighting after search
-- (H)ighlight (O)ff
vim.keymap.set("n", "<leader>ho", ":nohlsearch<CR>", { desc = "Removing highlighted text after a search" })

-- easy window navigation with leader key
-- navigate to left, right, up, down (h,l,k,j)
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Navigate to left window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Navigate to right window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Navigate to window above" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Navigate to window below" })

-- resize windows with arrow keys easily
-- resize with Alt+Arrow Keys (upwards,downwards,left,right)
vim.keymap.set("n", "<A-Up>", ":resize +2<CR>", { desc = "Resize horizontally to be bigger" })
vim.keymap.set("n", "<A-Down>", ":resize -2<CR>", { desc = "Resize horizontally to be smaller" })
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "Resize vertically to be smaller" })
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "Resize vertically to be bigger" })

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

-- check spelling within file
vim.keymap.set("n", "<leader>cs", "<cmd>setlocal spell!<CR>", { desc = "[c]heck [s]pelling" })

-- from kickstart!
-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- easily navigate modes in terminal
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")
