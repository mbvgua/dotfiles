-- have a terminal within a terminal?!

return {
	"akinsho/toggleterm.nvim",
	-- enabled=false
	version = "v2.13.1",
	opts = {
		open_mapping = "<leader>,",
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		-- insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		autochdir = false,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
}
