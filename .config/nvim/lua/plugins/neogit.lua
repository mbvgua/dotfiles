-- just too good, should have used this sooner.
-- best git frontend, though a Magit imitation

return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"sindrets/diffview.nvim",
		"m00qek/baleia.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "show neogit ui" },
	},
}
