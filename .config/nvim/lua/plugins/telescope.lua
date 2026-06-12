-- the modern fuzzy finder!

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			-- Default configuration for telescope goes here:
			defaults = {
				-- horizontal | center | cursor | vertical | bottom_pane
				layout_strategy = "horizontal",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden", -- Search hidden files (e.g., .env)
					"--no-ignore", -- Don't respect .gitignore
					"--glob",
					"!**/.git/*", -- Exclude .git directory
					"--glob",
					"!**/node_modules/*", -- Exclude node_modules directory
					"--glob",
					"!**/.venv/*",
				},
			},
			pickers = {
				-- This configures the `find_files` picker
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--no-ignore",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/node_modules/*",
						"--glob",
						"!**/.venv/*",
					},
				},
			},
		})

		-- edit neovim config files from wherever. Thanks to TJ!
		vim.keymap.set("n", "<leader>fc", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "[f]ind [c]onfig files" })

		-- open the find files on one click
		vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[f]ind [f]iles" })

		-- for live-grep (find by words)
		vim.keymap.set(
			"n",
			"<leader>fw",
			require("telescope.builtin").live_grep,
			{ desc = "[f]ind [w]ord by live grep" }
		)

		-- find all word occurrences when hovered
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").grep_string, { desc = "[f]ind [h]overed word" })

		-- move around buffers easily. Blew my mind dude!!
		vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[f]ind [b]uffers" })

		-- easily move around :help docs. This cemented telescope as the greatest plugin!
		vim.keymap.set("n", "<leader>f?", require("telescope.builtin").help_tags, { desc = "[f]ind help" })

		-- search through old opened files
		vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "[f]ind [r]ecent files" })

		-- find lsp symbols. like  moving through tree-sitter nodes
		vim.keymap.set(
			"n",
			"<leader>fl",
			require("telescope.builtin").lsp_document_symbols,
			{ desc = "[f]ind [l]sp symbols" }
		)

		-- find todo comments easily
		vim.keymap.set("n", "<leader>ft", "<cmd>:TodoTelescope<cr>", { desc = "[f]ind [t]odos" })
	end,
}
