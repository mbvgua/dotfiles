-- change my ui

return {
	-- monokai pro colorscheme. matches Sublime superbly!
	{
		"loctvl842/monokai-pro.nvim",
		version = "v1.26.0",
		-- enabled=false,
		config = function()
			require("monokai-pro").setup({
				terminal_colors = true,
				devicons = true,

				-- make transparent or not.
				transparent_background = false,
				styles = {
					comment = { italic = true },
					keyword = { italic = true }, -- any other keyword
					type = { italic = true }, -- (preferred) int, long, char, etc
					storageclass = { italic = true }, -- static, register, volatile, etc
					structure = { italic = true }, -- struct, union, enum, etc
					parameter = { italic = true }, -- parameter pass in function
					annotation = { italic = true },
					tag_attribute = { italic = true }, -- attribute of tag in reactjs
				},
				-- classic | octagon | pro | machine | ristretto | spectrum
				filter = "classic",
				day_night = {
					enable = false, -- turn off by default. light theme not that good
					day_filter = "light",
					night_filter = "classic",
				},
				inc_search = "background", -- underline | background
				background_clear = {
					"float_win",
					"toggleterm",
					"telescope",
					"which-key",
					"notify",
					"nvim-tree",
					"bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
					-- "renamer",
				},
				plugins = {
					bufferline = {
						underline_selected = false,
						underline_visible = false,
					},
					indent_blankline = {
						context_highlight = "default", -- default | pro
						context_start_underline = false,
					},
				},
			})
		end,
	},

	-- display a nice file tree while browsing directories
	{
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
							unstaged = "",
							staged = "S",
							renamed = "R",
							untracked = "U",
							unmerged = "",
							deleted = "✗",
							ignored = "◌",
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
	},

	-- statusline and bufferline settings
	{
		"nvim-lualine/lualine.nvim",
		-- enabled=false,
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				always_divide_middle = true,
				always_show_tabline = true,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "NvimTree" },
					winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "NvimTree" },
				},
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" } } },
				lualine_b = {
					{ "branch", icon = "" },
					{ "diff" },
				},
				lualine_c = {
					{ "diagnostics" },
					{
						shorting_target = 40,
						newfile_status = true,
						symbols = {
							modified = "",
							readonly = "",
							unnamed = "[No Name]",
							newfile = "",
						},
					},
				},
				lualine_x = {
					{
						"lsp_status",
						icon = "",
						symbols = {
							-- Standard unicode symbols to cycle through for LSP progress:
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							-- Standard unicode symbol for when LSP is done:
							done = "✓",
							separator = " ",
						},
						ignore_lsp = {},
					},
				},
				lualine_y = {
					-- already in tabline. total duplication
					-- also want to minimize items on statusline
					-- { "filetype", icon = { align = "right" } },
					-- "fileformat",
				},
				lualine_z = {
					{
						function()
							return "LOC: " .. vim.fn.line(".") .. "/" .. vim.fn.line("$")
						end,
						separator = { left = "", right = "" },
					},
				},
			},
			tabline = {
				lualine_a = { "buffers" }, -- show open buffers(numbered)
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "tabs" }, -- show open tabs
			},
		},
	},

	-- make most UI elements alot nicer visually, e/g code actions with the lsp
	{
		"folke/snacks.nvim",
		-- enabled = false,
		-- version = "v2.31.0",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			words = { enabled = true },
			animate = { enabled = true },
			bigfile = { enabled = true }, -- loads extremely large files with ease
			quickfile = { enabled = true }, -- render a new file as quick as possible before icons
			notifier = {
				enabled = true,
				-- compact | minimal | fancy
				style = "compact",
				timeout = 4000,
			},
			-- not in use...
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
	},

	-- devicons for displaying various glyphs
	{
		"nvim-tree/nvim-web-devicons",
		version = "0.100",
		-- enabled = false,
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				default = true,
				strict = true,
				variant = "light|dark",
			})
		end,
	},
}
