-- add some git integration
-- no use of hunks and blames heavy features, just basic highlighting of changes

return {
	{
		"lewis6991/gitsigns.nvim",
		version = "1.0.2",
		-- enabled = false,
		config = true,
		opts = {
			-- ctrl+c ctrl+v from kickstart. but hey, it works
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- only functionality added is git blame. dont need the rest rn
				map("n", "<leader>cb", gitsigns.toggle_current_line_blame, { desc = "[C]ode [b]lame git line" })
			end,
		},
	},
}
