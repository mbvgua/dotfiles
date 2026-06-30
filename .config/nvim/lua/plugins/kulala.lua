-- simple rest-cient

return {

	"mistweaverco/kulala.nvim",
	tag = "v5.2.1",
	-- enabled = false,
	keys = {
		{ "<CR>", desc = "Send request" },
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
}
