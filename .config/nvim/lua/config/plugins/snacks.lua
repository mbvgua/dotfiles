-- make most UI elements alot nicer visually, e/g code actions with the lsp

return {
	"folke/snacks.nvim",
	version = "v2.22.0",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = false },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
}
