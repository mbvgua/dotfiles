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
						vim.cmd.normal({ "]g", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next [g]it change" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[g", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous [g]it change" })

				-- only functionality added is git blame. dont need the rest rn
				map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "[g]it code [b]lame" })
			end,
		},
	},

	-- just too good, should have used this sooner.
	-- also,one less reason to move to emacs :)
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"sindrets/diffview.nvim",
			"m00qek/baleia.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "show neogit ui" },
		},
	},
}
