-- manage all your code formatters from a single place, e.g prettier,black

return {
	"stevearc/conform.nvim",
	version = "9.0.0",
	opts = {
		-- disabled temporarily. Dont like forced formats
		-- -- format on save automatically
		-- format_on_save = {
		-- 	-- These options will be passed to conform.format()
		-- 	timeout_ms = 500,
		-- 	lsp_format = "fallback",
		-- },
		-- installed formatters
		formatters_by_ft = {
			-- frontend
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			-- frameworks
			angular = { "prettierd", "prettier", stop_after_first = true },
			vue = { "prettierd", "prettier", stop_after_first = true },
			-- langs
			lua = { "stylua" },
			python = { "black" },
			sql = { "sql-formatter" },
		},
	},
	-- format using key bindings
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ lsp_format = "fallback", async = true })
		print("File formatted")
	end, { desc = "[c]ode [f]ormat" }),
}
