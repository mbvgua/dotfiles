-- devicons for displaying various glyphs

return {
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
}
