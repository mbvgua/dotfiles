-- setup the statusline and bufferline to be more informative and prettier

return {
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
			-- only 1 statusline for all windows/buffers
			-- globalstatus = true,
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" } } },
			lualine_b = {
				{ "branch", icon = "" },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_c = {
				{ "diagnostics" },
				{
					-- shown in tabline & also when i save a file
					-- "filename", -- present in filetree/telescope & buffername
					-- Values:   0: Just the filename
					--           1: Relative path
					--           2: Absolute path
					--           3: Absolute path, with tilde as the home directory
					--           4: Filename and parent dir, with tilde as the home directory
					-- path = 4,
					-- shorten path to leave 40 spaces in window
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
			-- TODO: add the LSP ICON here instead of search count
			lualine_x = {
				{
					"lsp_status",
					icon = "", -- f013
					symbols = {
						-- Standard unicode symbols to cycle through for LSP progress:
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						-- Standard unicode symbol for when LSP is done:
						done = "✓",
						-- Delimiter inserted between LSP names:
						separator = " ",
					},
					-- List of LSP names to ignore (e.g., `null-ls`):
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
					-- show line of code in file, like Vim. but proved quite hard
					-- TODO: make this more readable later on, quite hard
					-- still works like: '%l/%L' in vim statusline
					-- . -> current line no. $ -> total lines
					function()
						return "LOC: " .. vim.fn.line(".") .. "/" .. vim.fn.line("$")
					end,
					separator = { left = "", right = "" },
				},
			},
		},
		tabline = {
			-- show open buffers
			lualine_a = { "buffers" },
			lualine_b = { "" },
			lualine_c = { "" },
			lualine_x = {},
			lualine_y = {},
			-- show open tabs
			lualine_z = { "tabs" },
		},
	},
}
