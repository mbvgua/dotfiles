-- meta accessors for keymaps
local vim = vim or {}
local map = vim.keymap.set

-- file actions
-- save current file
map("n", "<leader>w", "<cmd>write<cr>", { desc = "save file" })

-- select entire file, then perform action c/y/d/gU/gu
map({ "n", "v" }, "<C-a>", "ggVG", { desc = "select entire file" })

-- check spelling within file
map("n", "<leader>cs", "<cmd>setlocal spell!<CR>", { desc = "[c]heck [s]pelling" })

-- stop highlighting after search
map("n", "<esc>", ":nohlsearch<CR>", { desc = "[c]heck spelling [o]ff" })

-- remain in visual mode while identing to the right/left
map("v", "<", "<gv", { desc = "ident leftwards" })
map("v", ">", ">gv", { desc = "ident rightwards" })

-- Continously move block of text up and down
map({ "v", "x" }, "<A-k>", ":move '<-2<CR>gv-gv", { desc = "move chunk upwards" })
map({ "v", "x" }, "<A-j>", ":move '>+1<CR>gv-gv", { desc = "move chunk downwards" })

-- window actions
-- close current window
map("n", "<leader>x", "<c-w>c", { desc = "close current window" })

-- window navigation with leader-(h,l,k,j)
map("n", "<leader>h", "<C-w>h", { desc = "navigate to left window" })
map("n", "<leader>l", "<C-w>l", { desc = "navigate to right window" })
map("n", "<leader>k", "<C-w>k", { desc = "navigate to window above" })
map("n", "<leader>j", "<C-w>j", { desc = "navigate to window below" })

-- resize windows with Ctrl+h\j\k\l Keys
map("n", "<C-k>", ":resize +2<CR>", { desc = "resize horizontally to be bigger" })
map("n", "<C-j>", ":resize -2<CR>", { desc = "resize horizontally to be smaller" })
map("n", "<C-h>", ":vertical resize -2<CR>", { desc = "resize vertically to be smaller" })
map("n", "<C-l>", ":vertical resize +2<CR>", { desc = "resize vertically to be bigger" })

-- easily split windows with - & | like tmux
map("n", "<leader>-", ":split<CR>", { desc = "[-]Split window horizontally " })
map("n", "<leader>\\", ":vsplit<CR>", { desc = "[|] Split window vertically " })

-- buffer actions
-- navigate buffers with leader-(n)ext and (p)revious
map("n", "<leader>n", ":bnext<CR>", { desc = "[n]ext buffer" })
map("n", "<leader>p", ":bprevious<CR>", { desc = "[p]revious buffer" })

-- delete current buffer
map("n", "<leader>bd", ":bd<CR>", { desc = "current [b]uffer [d]elete" })

-- delete all buffers in background
map("n", "<leader>bb", function()
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
end, { desc = "delete all [b]uffers in [b]ackgrond" })

-- tabs actions
-- navigate tabs. dont use tabs alot though
map("n", "<leader>ta", ":tabnew<CR>", { desc = "[t]ab [a]dd" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "[t]ab [n]ext" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "[t]ab [p]revious" })
map("n", "<leader>tx", ":tabclose<CR>", { desc = "delete current [t]ab" })
map("n", "<leader>tb", ":tabonly<CR>", { desc = "delete all [t]abs in [b]ackground" })

-- inspect tree
map("n", "<leader>ci", "<cmd>InspectTree<CR>", { desc = "[c]ode [i]nspect tree-sitter" })

-- Hardmode: Disable arrow keys in normal & visual mode
map({ "v", "n" }, "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
map({ "v", "n" }, "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
map({ "v", "n" }, "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
map({ "v", "n" }, "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')

-- insert templates
-- Learnt from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
map({ "n", "x" }, "<leader>!", ":-1read $HOME/.config/nvim/base.html<CR>8jwf>a", { desc = "insert html boilerplate" })
