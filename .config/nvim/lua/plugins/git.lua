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

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next [g]it change" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous [g]it change" })

				-- only functionality added is git blame. dont need the rest rn
				map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "[g]it code blame" })
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
			vim.keymap.set("n", "<leader>gdc", [[:DiffviewClose<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>gdo", [[:DiffviewOpen<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>gdd", [[:DiffviewOpen develop<CR>]], { silent = true })
			vim.keymap.set("n", "<leader>gdh", [[:DiffviewFileHistory %<CR>]], { silent = true })
		end,
	},
}
