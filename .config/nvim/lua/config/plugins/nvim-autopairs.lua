-- autopairs for {,[,(,",',`

return {
	{
		"windwp/nvim-autopairs",
		-- enabled = false,
		event = "InsertEnter",
		config = true,
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
}
