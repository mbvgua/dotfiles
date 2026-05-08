-- manage all your code formatters from a single place, e.g prettier,black

return {
	"stevearc/conform.nvim",
	version = "9.0.0",
	-- enabled = false,
	opts = {
		formatters_by_ft = {
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			angular = { "prettierd", "prettier", stop_after_first = true },
			lua = { "stylua" },
			python = { "black" },
			c = { "clangd" },
			cpp = { "clangd" },
		},
	},
	-- format using key bindings
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ lsp_format = "fallback", async = true })
		print("File formatted")
	end, { desc = "[c]ode [f]ormat" }),
}
