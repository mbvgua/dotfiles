-- the modern fuzzy finder!

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				-- Default configuration for telescope goes here:
				-- config_key = value,
				mappings = {
					i = {
						-- move to prev and next search term in history
						["<C-k>"] = actions.cycle_history_next,
						["<C-j>"] = actions.cycle_history_prev,
						-- move up and down in selection
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-c>"] = actions.close,

						-- show possible key values
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},
					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
		})

		-- edit neovim config files from wherever. Thanks to TJ!
		vim.keymap.set("n", "<leader>fc", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
				desc = "[f]ind [c]onfig files",
			})
		end)

		-- open the find files on one click
		vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[f]ind [f]iles" })

		-- for live-grep (find by words)
		vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[f]ind word by live [g]rep" })

		-- find all word occurrences when hovered
		vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[f]ind hovered [w]ord" })

		-- move around buffers easily. Blew my mind dude!!
		vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[f]ind [b]uffers" })

		-- easily move around :help docs. This cemented telescope as the greatest plugin!
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[f]ind [h]elp" })

		-- search through old opened files
		vim.keymap.set("n", "<leader>fo", require("telescope.builtin").oldfiles, { desc = "[f]ind [o]ld files" })

		-- find lsp symbols. Does not work now, I have no lsp client.
		vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, { desc = "[f]ind [l]sp symbols" })

		-- find your preset keymaps
		vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, { desc = "[f]ind [k]eymaps" })

		-- resume previous search
		vim.keymap.set("n", "<leader>fp", require("telescope.builtin").resume, { desc = "[f]ind [p]revious search" })

		-- find todo comments easily
		vim.keymap.set("n", "<leader>ft", "<cmd>:TodoTelescope<cr>", { desc = "[f]ind [t]odos" })

	end,
}
