-- make most UI elements alot nicer visually, e/g code actions with the lsp

return {
	"folke/snacks.nvim",
	-- enabled = false,
	version = "v2.22.0",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		indent = { enabled = true },
		input = { enabled = true, prompt_pos = "left" },
		picker = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
		animate = { enabled = true },
		bigfile = { enabled = true },
		notifier = {
			enabled = true,
			style = "fancy",
			timeout = 4000,
			wo = { wrap = true },
		},
		-- not in use...
		quickfile = { enabled = false }, -- not sure what this does. but no
		dashboard = { enabled = false }, -- too much. totally uneccessary
		explorer = { enabled = false }, -- have netrw!
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
