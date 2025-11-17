-- easily navigate across vim marks

return {
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		-- enable = false,
		config = function()
			require("marks").setup({
				opts = {
					-- Defaults
					-- which builtin marks to show. default {}
					builtin_marks = { ".", "<", ">", "^" },
					-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
					-- marks, and bookmarks.
					-- can be either a table with all/none of the keys, or a single number, in which case
					-- the priority applies to all marks.
					-- default 10.
					sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
				},
				mappings = {
					-- apat from moving with `x, this makes mvmnt much easier
					next = "]m", -- move to next mark
					prev = "[m", -- move to previous mark
					-- mx -> set mark x
					-- dmx -> delete mark x
					-- dm<space> -> delete all marks in current buffer
				},
			})
		end,
	},
}
