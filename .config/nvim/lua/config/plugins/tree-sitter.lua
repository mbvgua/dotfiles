-- install tree-sitter. for better syntax highlighting
-- and code navigation

return {
	"nvim-treesitter/nvim-treesitter",
	version = "v0.9.3",
	-- enabled = false,
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"cmake",
				"make",
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
				"php",
				"lua",
				"vue",
				"angular",
				"sql",
			},
			sync_install = false,
			highlight = { enable = true },
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

		-- inspect tree sitter syntax easily
		vim.keymap.set("n", "<leader>ci", "<cmd>:InspectTree<CR>", { desc = "[c]ode [i]nspect tree-sitter" })
	end,
}
