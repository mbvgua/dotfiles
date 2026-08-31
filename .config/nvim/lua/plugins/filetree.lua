-- display a nice file tree while browsing directories

-- Define a function to apply the matching highlights
local function sync_git_colors()
	-- Map: Filetree Highlight Group = Gitsigns Highlight Group
	local git_hl_map = {
		-- For nvim-tree
		NvimTreeGitDirty = "GitSignsChange",
		NvimTreeGitStaged = "GitSignsAdd", -- Or a custom staged color if your theme has one
		NvimTreeGitNew = "GitSignsAdd",
		NvimTreeGitDeleted = "GitSignsDelete",
		NvimTreeGitRenamed = "GitSignsChange",
	}

	for tree_hl, git_hl in pairs(git_hl_map) do
		vim.api.nvim_set_hl(0, tree_hl, { link = git_hl, default = true })
	end
end

-- Run it immediately
sync_git_colors()

-- custom mappings
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.map.on_attach.default(bufnr)

	-- custom mappings(:h nvim-tree-mappings-default)
	vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts("Prev Git"))
	vim.keymap.set("n", "]g", api.node.navigate.git.next, opts("Next Git"))
end

-- open non-text based files with external apps
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	-- Load all default nvim-tree keybindings first
	api.config.mappings.default_on_attach(bufnr)

	-- Custom function to open file or run external application
	local function open_file_or_external()
		local node = api.tree.get_node_under_cursor()
		if not node then
			return
		end

		if node.type == "directory" then
			api.node.open.edit() -- Expand / collapse directories as normal
		elseif node.type == "file" then
			local filepath = node.absolute_path
			local ext = vim.fn.fnamemodify(filepath, ":e"):lower()

			-- Map file extensions to your preferred apps
			local external_apps = {
				-- Documents
				pdf = "zathura",
				doc = "libreoffice",
				docx = "libreoffice",
				odt = "libreoffice",
				xls = "libreoffice",
				xlsx = "libreoffice",
				ppt = "libreoffice",
				pptx = "libreoffice",

				-- Images
				png = "feh",
				jpg = "feh",
				jpeg = "feh",
				gif = "feh",
				webp = "feh",

				-- Audio & Video
				mp4 = "mpv",
				mkv = "mpv",
				avi = "mpv",
				webm = "mpv",
				mp3 = "mpv",
				flac = "mpv",
				wav = "mpv",
				ogg = "mpv",
			}

			local app = external_apps[ext]
			if app then
				-- Launch externally in a detached background job
				vim.fn.jobstart({ app, filepath }, { detach = true })
			else
				-- Default behavior: open inside Neovim
				api.node.open.edit()
			end
		end
	end

	-- Keymaps for nvim-tree buffer
	local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

	vim.keymap.set("n", "<CR>", open_file_or_external, opts)
	vim.keymap.set("n", "<2-LeftMouse>", open_file_or_external, opts)
	vim.keymap.set("n", "o", open_file_or_external, opts)
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "v1.17.0",
	-- enabled = false,
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		on_attach = my_on_attach,
		hijack_netrw = true,
		disable_netrw = true,
		view = {
			side = "right",
		},
		renderer = {
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				glyphs = {
					git = {
						unstaged = "~", -- modified/edited
						untracked = "+", -- added as new
						renamed = "→", -- existed but now renamed
						ignored = "◌", -- ignored by git
						unmerged = "?", -- urgent merge conflict
						staged = "✓", -- staged and ready
						deleted = "✖", -- removed from git tracking
					},
				},
			},
		},
		-- change directories with me as I navigate!
		update_focused_file = {
			enable = true,
			update_root = {
				enable = true,
				ignore_list = {},
			},
			exclude = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 500,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = {
				"/.ccls-cache",
				"/build",
				"/node_modules",
				"/target",
				"/.venv",
				"/.env",
			},
		},

		-- custom mapping to toggle easily
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "toggle [e]xplorer" }),
	},
}
