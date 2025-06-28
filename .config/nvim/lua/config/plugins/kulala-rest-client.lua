-- simple rest-cient

return {
	"mistweaverco/kulala.nvim",
	tag = "v5.2.1",
	keys = {
		-- { "<leader>Rs", desc = "Send request" },
		-- remapped to <CR> to move faster. Only works in .http files, amazing!!
		{ "<CR>", desc = "Send request" },
		-- dont need these keys. Currently
		-- { "<leader>Ra", desc = "Send all requests" },
		-- { "<leader>Rb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
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
