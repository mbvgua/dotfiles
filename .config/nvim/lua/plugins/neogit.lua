-- magit, but in neovim. best git frontend

return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"sindrets/diffview.nvim",
		"m00qek/baleia.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "show neo[g]it ui" },
		{ "<leader>gd", "<cmd>Neogit diff<cr>", desc = "show [g]it [d]iff in current file" },
	},
}
