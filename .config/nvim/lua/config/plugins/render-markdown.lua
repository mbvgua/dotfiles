-- view markdown files from within neovim

return {
	"MeanderingProgrammer/render-markdown.nvim",
	version = "v8.7.0",
	-- enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	}, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
}
