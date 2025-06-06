-- install tree-sitter. for better syntax highlighting

return {
	"nvim-treesitter/nvim-treesitter",
	version = "v0.10.0",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"zig",
				"rust",
				"odin",
				"cmake",
				"make",
				"meson",
				"dockerfile",
				"nginx",
				"markdown",
				"yaml",
				"json",
				"html",
				"css",
				"jinja",
				"http",
				"javascript",
				"typescript",
				"python",
				"perl",
				"lua",
				"vue",
				"angular",
				"graphql",
				"sql",
			},
			sync_install = false,
			highlight = { enable = true },
			-- indent with =
			indent = { enable = true },

			-- easier navigation of textObjects
			-- TODO: learn how to use advanced text objects mapping
			-- either in vanilla vim or using tree-sitter syntax mapping(ac,ic,af,if)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>", -- set to `false` to disable one of the mappings
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
		})
	end,
}
