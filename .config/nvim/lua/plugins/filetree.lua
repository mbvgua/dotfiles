-- display a nice file tree while browsing directories

return {
	"nvim-tree/nvim-tree.lua",
	version = "v1.17.0",
	-- enabled = false,
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		hijack_netrw = true,
		disable_netrw = true,
		view = {
			side = "right",
		},
		renderer = {
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				glyphs = {
					git = {
						unstaged = "",
						staged = "S",
						renamed = "R",
						untracked = "",
						deleted = "",
						ignored = "◌",
						unmerged = "",
					},
				},
			},
		},
		-- change directories with me as I navigate!
		update_focused_file = {
			enable = true,
			update_root = {
				enable = true,
				ignore_list = {},
			},
			exclude = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 500,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = {
				"/.ccls-cache",
				"/build",
				"/node_modules",
				"/target",
				"/.venv",
				"/.env",
			},
		},

		-- custom mapping to toggle easily
		vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>", { desc = "toggle [e]xplorer" }),
	},
}
