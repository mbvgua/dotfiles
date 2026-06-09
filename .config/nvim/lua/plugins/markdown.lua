-- help with documentation writing

return {
	-- better markdown workflow
	{
		"MeanderingProgrammer/render-markdown.nvim",
		version = "v8.12.0",
		-- enabled = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			latex = { enabled = false },
		},
	},
}
