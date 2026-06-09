-- project.nvim: capable projectile clone
local map = vim.keymap.set

return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			-- Detection methods in order of priority
			detection_methods = { "lsp", "pattern" },

			-- Patterns to detect project root
			patterns = {
				".git",
				"Makefile",
				"package.json",
				"pyproject.toml",
				"setup.py",
				"Cargo.toml",
				"requirements.txt",
				"info.rkt", -- racket
			},

			-- Don't change cwd for every buffer, only explicit project switches
			scope_chdir = "global",

			-- Show hidden files in picker
			show_untracked = true,

			-- Remember this many projects
			datapath = vim.fn.stdpath("data"), -- stored in ~/.local/share/nvim/
		})

		-- Hook into telescope
		require("telescope").load_extension("projects")

		-- project wide navigation keymaps
		map("n", "<leader>fp", function()
			require("telescope").extensions.projects.projects({})
		end, { desc = "[f]ind [p]roject & switch" })

		map("n", "<leader>fpb", function()
			require("telescope.builtin").buffers({
				cwd = require("project_nvim.project").get_project_root(),
				cwd_only = true,
			})
		end, { desc = "[f]ind [p]roject [b]uffers" })
	end,
}
