local vim = vim or {}

-- meta accessor for keymap
local map = vim.keymap.set

-- Normal Mode Tricks
-- copy & paste with Shift-(y/p)
map({ "n", "x" }, "<S-y>", '"+y', { desc = "copy to clipboard" })
map({ "n", "x" }, "<S-p>", '"+p', { desc = "paste clipboard" })

-- save current file
map("n", "<leader>w", "<cmd>write<cr>", { desc = "save file" })

-- close current window
map("n", "<leader>x", "<c-w>c", { desc = "close current window" })

-- stop highlighting after search
map("n", "<leader>so", ":nohlsearch<CR>", { desc = "removing highlighted text after a search" })

-- check spelling within file
map("n", "<leader>cs", "<cmd>setlocal spell!<CR>", { desc = "[c]heck [s]pelling" })

-- window navigation with leader-(h,l,k,j)
map("n", "<leader>h", "<C-w>h", { desc = "navigate to left window" })
map("n", "<leader>l", "<C-w>l", { desc = "navigate to right window" })
map("n", "<leader>k", "<C-w>k", { desc = "navigate to window above" })
map("n", "<leader>j", "<C-w>j", { desc = "navigate to window below" })

-- resize windows with Ctrl+h\j\k\l Keys. like tmux
map("n", "<A-k>", ":resize +2<CR>", { desc = "resize horizontally to be bigger" })
map("n", "<A-j>", ":resize -2<CR>", { desc = "resize horizontally to be smaller" })
map("n", "<A-h>", ":vertical resize -2<CR>", { desc = "resize vertically to be smaller" })
map("n", "<A-l>", ":vertical resize +2<CR>", { desc = "resize vertically to be bigger" })

-- navigate buffers easily with leader-(N)ext and (P)revious
map("n", "<leader>n", ":bnext<CR>", { desc = "navigate to next buffer" })
map("n", "<leader>p", ":bprevious<CR>", { desc = "navigate to previous buffer" })

-- easily split windows with - & | like tmux
map("n", "<leader>-",":split<CR>",{desc = "[-]Split window horizontally "})
map("n", "<leader>\\",":vsplit<CR>",{desc = "[|] Split window vertically "})

-- Hardmode ON!! from kickstart nvim
-- Disable arrow keys in normal & visual mode
map({"v","n"}, "<left>", '<cmd>echohl Error | echo "Youre in Hardmode.Use h to move!!" | echohl None<CR>')
map({"v","n"}, "<right>", '<cmd>echohl Error | echo "Youre in Hardmode.Use l to move!!" | echohl None<CR>')
map({"v","n"}, "<up>", '<cmd>echohl Error | echo "Youre in Hardmode.Use k to move!!" | echohl None<CR>')
map({"v","n"}, "<down>", '<cmd>echohl Error | echo "Youre in Hardmode.Use j to move!!" | echohl None<CR>')

-- Visual Mode Tricks
-- remain in visual mode while identing to the right/left
map("v", "<", "<gv", { desc = "ident leftwards" })
map("v", ">", ">gv", { desc = "ident rightwards" })

-- Continously move block of text up and down
map({"v","x"}, "K", ":move '<-2<CR>gv-gv",{ desc = "move chunk upwards" })
map({"v","x"}, "J", ":move '>+1<CR>gv-gv",{desc="move chunk downwards"} )
map({"v","x"}, "<A-k>", ":move '<-2<CR>gv-gv",{ desc = "move chunk upwards" })
map({"v","x"}, "<A-j>", ":move '>+1<CR>gv-gv", { desc = "move chunk downwards" })

-- delete current buffer
map("n","<leader>bb",":bd<CR>",{desc="[d]elete current [b]uffer"})

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

-- insert base html desc
-- Learnt from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
map({ "n", "x" }, "<leader>!", ":-1read $HOME/.config/nvim/base.html<cR>9jwf>a", { desc = "insert html boilerplate" })
