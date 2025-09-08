local vim = vim or {}

-- meta accessor for keymap
local map = vim.keymap.set

-- Normal Mode Tricks
-- copy & paste with Shift-(y/p)
map({ "n", "x" }, "<S-y>", '"+y', { desc = "copy to clipboard" })
map({ "n", "x" }, "<S-p>", '"+p', { desc = "paste clipboard text" })

-- save current file
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })

-- close current window
map("n", "<leader>x", "<C-w>c", { desc = "Close current window" })

-- stop highlighting after search
map("n", "<leader>ho", ":nohlsearch<CR>", { desc = "Removing highlighted text after a search" })

-- check spelling within file
map("n", "<leader>cs", "<cmd>setlocal spell!<CR>", { desc = "[c]heck [s]pelling" })

-- window navigation with leader-(h,l,k,j)
map("n", "<leader>h", "<C-w>h", { desc = "Navigate to left window" })
map("n", "<leader>l", "<C-w>l", { desc = "Navigate to right window" })
map("n", "<leader>k", "<C-w>k", { desc = "Navigate to window above" })
map("n", "<leader>j", "<C-w>j", { desc = "Navigate to window below" })

-- resize windows with Alt+Arrow Keys (upwards,downwards,left,right)
map("n", "<A-k>", ":resize +2<CR>", { desc = "Resize horizontally to be bigger" })
map("n", "<A-j>", ":resize -2<CR>", { desc = "Resize horizontally to be smaller" })
map("n", "<A-h>", ":vertical resize -2<CR>", { desc = "Resize vertically to be smaller" })
map("n", "<A-l>", ":vertical resize +2<CR>", { desc = "Resize vertically to be bigger" })

-- navigate buffers easily with leader-(N)ext and (P)revious
map("n", "<leader>n", ":bnext<CR>", { desc = "Navigate to next buffer" })
map("n", "<leader>p", ":bprevious<CR>", { desc = "Navigate to previous buffer" })

-- easily split windows with - & | like tmux
map("n", "<leader>-",":split<CR>",{desc = "[-]Split window horizontally "})
map("n", "<leader>\\",":vsplit<CR>",{desc = "[|] Split window vertically "})

-- Hardmode ON!! from kickstart nvim
-- Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
map("n", "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
map("n", "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
map("n", "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')

-- Insert Mode Tricks
-- Disable arrow keys in insert mode with a styled message
-- map("i", "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
-- map("i", "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
-- map("i", "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
-- map("i", "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')

-- Visual Mode Tricks
-- remain in visual mode while identing to the right/left
map("v", "<", "<gv", { desc = "Ident leftwards" })
map("v", ">", ">gv", { desc = "Ident rightwards" })

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", { desc = "Move chunk downwards" })
map("v", "<A-k>", ":m .-2<CR>==", { desc = "Move chunk upwards" })

-- Continously move block of text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- delete all buffers in background
map("n", "<leader>bd", function()
	local current = vim.api.nvim_get_current_buf()

	-- First, save all modified buffers
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and vim.bo[buf].modified then
			vim.api.nvim_buf_call(buf, function()
				vim.cmd("write")
			end)
		end
	end

	-- Then, delete all except the current one
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "[d]elete all [b]uffers except current" })

-- Terminal Tricks
-- easily navigate modes in terminal
map("t", "<Esc>", "<C-\\><C-n>")

-- -- open work environemnts in toggleterm terminal
-- local Terminal = require("toggleterm.terminal").Terminal
-- local python = Terminal:new({ cmd = "python", hidden = true }) -- open python REPL
-- local mysql = Terminal:new({ cmd = "mysql -u root -p", hidden = true }) -- open MySql
--
-- function PYTHON_TOGGLE()
-- 	python:toggle()
-- end
-- map("n", "<C-p>", "<cmd> :lua PYTHON_TOGGLE()<CR> <cmd>")
-- map("i", "<C-p>", "<cmd> :lua PYTHON_TOGGLE()<CR> <cmd>")
--
-- function MYSQL_TOGGLE()
-- 	mysql:toggle()
-- end
-- map("n", "<C-m>", "<cmd> :lua MYSQL_TOGGLE()<CR> <cmd>")
-- map("i", "<C-m>", "<cmd> :lua MYSQL_TOGGLE()<CR> <cmd>")
