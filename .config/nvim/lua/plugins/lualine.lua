-- for a minimal & highly configurable statusline and bufferline

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
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{ "branch", icon = "" },
				{ "diff" },
			},
			lualine_x = {
				{
					"lsp_status",
					icon = "",
					symbols = {
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						done = "", -- when spinner disappears, I know its done!?
						separator = " ",
					},
				},
				{
					function()
						return "[" .. vim.fn.line(".") .. "/" .. vim.fn.line("$") .. "]"
					end,
				},
			},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = { "buffers" },          -- show open buffers(numbered)
			lualine_b = {},
			lualine_c = {},
			lualine_x = { "diagnostics" },      -- possible errors
			lualine_y = {},
			lualine_z = { "tabs" },             -- show open tabs(neogit mostly)
		},
	},
}
