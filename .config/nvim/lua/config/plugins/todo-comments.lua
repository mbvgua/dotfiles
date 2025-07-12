-- nice highlighting of todo comments

return {
	"folke/todo-comments.nvim",
	version = "v1.4.0",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- keywords recognized as todo comments
		keywords = {
			TODO = { icon = " ", color = "info" },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			FIX = { icon = " ", color = "error", alt = { "BUGFIX", "FIXME", "BUG", "FIXIT", "ISSUE" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "REFACTOR" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of highlight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "#38fa07" },
			-- test = { "Identifier", "#38fa07" },
		},
	},
}
