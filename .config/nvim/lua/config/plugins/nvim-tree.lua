-- display nice file/directory icons when browsing with netrw
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- custom mappings function
local my_on_attach = function(bufnr)
	local api = require("nvim-tree.api")
	local map = vim.keymap.set

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- Custom mappings
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, silent = true, nowait = true }
	end
	map("n", "?", api.tree.toggle_help, opts("Open: No Window Picker"))
	-- NOTE: opted for the defaults. keep just incase...
	-- map("n", "<leader>ed", api.tree.toggle_hidden_filter)
	-- map("n", "<leader>eg", api.tree.toggle_gitignore_filter)
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	-- enabled=false,
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		on_attach = my_on_attach,
		view = {
			side = "right",
		},
		-- my custom mappings
		-- toggle easily with <Leader>e
		vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>", { desc = "toggle [e]xplorer" }),
		vim.keymap.set("n", "<leader>E", "<cmd>:NvimTreeFocus<CR>", { desc = "[e]xplorer focus" }),
	},
}
