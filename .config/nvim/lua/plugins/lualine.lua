-- statusline and bufferline settings

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
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "NvimTree" },
				winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "NvimTree" },
			},
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" } } },
			lualine_b = {
				{ "branch", icon = "" },
			},
			lualine_c = {
				{ "diff" },
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
			lualine_y = {},
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
			lualine_x = {
				{
					"diagnostics",
					-- colored = false,
				},
			},
			lualine_y = {},
			lualine_z = { "tabs" }, -- show open tabs
		},
	},
}
