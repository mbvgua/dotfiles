-- move better

return {
	-- the modern fuzzy finder!
	{
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
			vim.keymap.set(
				"n",
				"<leader>fh",
				require("telescope.builtin").grep_string,
				{ desc = "[f]ind [h]overed word" }
			)

			-- move around buffers easily. Blew my mind dude!!
			vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[f]ind [b]uffers" })

			-- easily move around :help docs. This cemented telescope as the greatest plugin!
			vim.keymap.set("n", "<leader>f?", require("telescope.builtin").help_tags, { desc = "[f]ind help" })

			-- search through old opened files
			vim.keymap.set("n", "<leader>fo", require("telescope.builtin").oldfiles, { desc = "[f]ind [o]ld files" })

			-- find lsp symbols. Does not work now, I have no lsp client.
			vim.keymap.set(
				"n",
				"<leader>fl",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "[f]ind [l]sp symbols" }
			)

			-- find todo comments easily
			vim.keymap.set("n", "<leader>ft", "<cmd>:TodoTelescope<cr>", { desc = "[f]ind [t]odos" })
		end,
	},

	-- easily navigate across vim marks
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		-- enable = false,
		config = function()
			require("marks").setup({
				opts = {
					-- which builtin marks to show. default {}
					builtin_marks = { ".", "<", ">", "^" },
					-- sign priorities for each type of mark - builtin, uppercase, lowercase
					-- marks, and bookmarks. default 10.
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

	-- quick popup for keymaps for memorability
	{
		"folke/which-key.nvim",
		version = "v3.17.0",
		-- enabled = false,
		event = "VeryLazy",
		opts = {
			-- classic | modern | helix
			preset = "helix",
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Which key: Buffer Local Keymaps",
			},
		},
	},
}
