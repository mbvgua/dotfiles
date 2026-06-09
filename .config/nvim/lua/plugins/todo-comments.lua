-- highlighting of todo comments

return {
	"folke/todo-comments.nvim",
	version = "v1.5.0",
	-- enabled = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- keywords recognized as todo comments
		keywords = {
		    -- reminder to add/change sth at a later  date
			TODO = { icon = "󰓾 ", color = "info" },
            -- For code (or code paths) that are broken, unimplemented, or slow,
            -- and may become bigger problems later.
			FIXME = { icon = "󰓾 ", color = "error", alt = { "BUGFIX", "FIX", "BUG", "FIXIT", "ISSUE" } },
            -- For code that needs to be revisited later, either to upstream it,
            -- improve it, or address non-critical issues.
			REVIEW = { icon = "󰓾 ", alt = { "PERFORMANCE", "OPTIMIZE", "REFACTOR" } },
            -- For sections of code that just gotta go, and will be gone soon.
            -- Specifically, this means the code is deprecated, not necessarily
            -- the feature it enables.
			DEPRECATED = { icon = "󰓾 ", color = "warning", alt = { "HACK", "WARN", "WARNING", "XXX" } },
			NOTE = { icon = "󰓾 ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "󰓾 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
        highlight = {
            multiline = false, -- only 1  line.wouldve been better if only the keyword
        },
		-- list of named colors where we try to extract the guifg from the
		-- list of highlight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "#38fa07" }, -- Removed "Identifier" to make it green, not white
		},
	},
	-- move across toggle todo comments easily
	vim.keymap.set("n", "]t", function()
		require("todo-comments").jump_next()
	end, { desc = "[n]ext [t]odo comment" }),

	vim.keymap.set("n", "[t", function()
		require("todo-comments").jump_prev()
	end, { desc = "[p]revious [t]odo comment" }),
}
