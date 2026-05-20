-- help when doing some webdev stuff

return {
	-- html tags auto closing
	{
		"windwp/nvim-ts-autotag",
		-- enable = false,
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},

	-- simple rest-cient
	{
		"mistweaverco/kulala.nvim",
		tag = "v5.2.1",
		-- enabled = false,
		keys = {
			{ "<CR>", desc = "Send request" },
			-- dont need these keys. Currently
			-- { "<leader>Ra", desc = "Send all requests" },
			-- { "<leader>Rb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			-- global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
			ui = { formatter = true },
		},
		-- recognize files with .http extension as http files
		vim.filetype.add({
			extension = {
				["http"] = "http",
			},
		}),
	},
}
