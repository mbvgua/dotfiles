-- simple rest-cient

return {
	"mistweaverco/kulala.nvim",
	keys = {
		{ "<leader>Rs", desc = "Send request" },
		{ "<leader>Ra", desc = "Send all requests" },
		{ "<leader>Rb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
	},
	-- recognize files with .http extension as http files
	vim.filetype.add({
		extension = {
			["http"] = "http",
		},
	}),
}
