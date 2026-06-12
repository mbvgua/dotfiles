-- project.el, but in neovim
local map = vim.keymap.set

return {
	"DrKJeff16/project.nvim",
	cmd = { "Project" }, -- Lazy-load by commands
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("project").setup()
	end,

	-- project wide navigation keymaps
	map("n", "<leader>fp", "<CMD>Project recents<CR>", { desc = "[f]ind recent [p]rojects" }),
}
