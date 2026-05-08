-- quick popup for keymaps for memorability

return {
	"folke/which-key.nvim",
	version = "v3.17.0",
	-- enabled = false,
	event = "VeryLazy",
	opts = {
		-- classic | modern | helix
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
