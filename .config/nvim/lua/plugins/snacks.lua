-- make most UI elements alot nicer visually

return {
	"folke/snacks.nvim",
	-- enabled = false,
	-- version = "v2.31.0",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		indent = { enabled = true },
		picker = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
		animate = { enabled = true },
		bigfile = { enabled = true }, -- loads extremely large files with ease
		quickfile = { enabled = true }, -- render a new file as quick as possible before icons
		notifier = {
			enabled = true,
			style = "compact",
			timeout = 4000,
		},
		-- not in use...
		input = { enabled = false }, -- like to give my input down at the bottom
		dashboard = { enabled = false }, -- too much. totally uneccessary
		explorer = { enabled = false }, -- have nvim-tree!
		terminal = { enabled = false }, -- float term is harzardous at best
		statuscolumn = { enabled = false }, -- lol. makes my numbers disappear
	},
	keys = {
		{
			"<leader>m",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "[m]essages history",
		},
	},
}
