-- quick popup for keymaps if i forget them
return {
	"folke/which-key.nvim",
	version = "v3.17.0",
	-- enabled = false,
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		preset = "helix",
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Which key: Buffer Local Keymaps",
		},
	},
}
