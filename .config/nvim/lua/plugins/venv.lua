return {
	"linux-cultist/venv-selector.nvim",
	-- enabled= false,
	config = function()
		require("venv-selector").setup({
			-- automatically activate a .venv found in project root
			auto_refresh = true,
			search = true,

			-- where to look for venvs
			search_venv_managers = true, -- finds pyenv, virtualenvwrapper etc
			search_workspace = true, -- searches project root
			parents = 2, -- how many dirs up to search

			-- names to look for
			name = { ".venv", "venv", ".env", "env" },

			-- notify when a venv is auto-activated
			notify_user_on_venv_activation = true,

			-- restart LSP when venv changes so pyright uses correct python
			changed_venv_hooks = {
				require("venv-selector").hooks.pyright,
			},
		})
	end,
	-- keys = {
	-- 	{ "<leader>cv", "<cmd>VenvSelect<CR>", desc = "[c]ode [v]env select" },
	-- 	{ "<leader>cV", "<cmd>VenvSelectCached<CR>", desc = "[c]ode [v]env cached" },
	-- },
}
