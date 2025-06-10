-- monokai pro colorscheme. matches Sublime superbly!

return {
	"loctvl842/monokai-pro.nvim",
	version = "v1.26.0",
	-- enabled=false,
	config = function()
		require("monokai-pro").setup({
			-- classic | octagon | pro | machine | ristretto | spectrum
			filter = "classic",
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
			-- Enable this will disable filter option
			day_night = {
				enable = false, -- turn off by default
				day_filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
				night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
			},
			inc_search = "background", -- underline | background
			background_clear = {
				-- "float_win",
				"toggleterm",
				"telescope",
				"which-key",
				"renamer",
				"notify",
				-- "nvim-tree",
				-- "neo-tree",
				-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
			}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
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

		-- set colorscheme to now configured monokai
		vim.cmd.colorscheme("monokai-pro")
	end,
}
