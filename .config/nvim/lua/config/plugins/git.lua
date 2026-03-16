-- add some git QoL integration

return {
	{
		"lewis6991/gitsigns.nvim",
		version = "1.0.2",
		-- enabled = false,
		config = true,
		opts = {
			-- ctrl+c ctrl+v from kickstart. but hey, it works
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- only functionality added is git blame. dont need the rest rn
				map("n", "<leader>cb", gitsigns.toggle_current_line_blame, { desc = "git [c]ode [b]lame" })
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
			vim.keymap.set("n", "<leader>dc", [[:DiffviewClose<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>do", [[:DiffviewOpen<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>dd", [[:DiffviewOpen develop<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>dh", [[:DiffviewFileHistory %<CR>]], { silent = true })
		end,
	},
}
