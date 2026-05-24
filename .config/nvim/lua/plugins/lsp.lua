-- setup for coding
local vim = vim or {}

return {
	-- install tree-sitter for better syntax highlighting and code navigation
	{
		"nvim-treesitter/nvim-treesitter",
		version = "v0.10.0",
		-- enabled = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"cmake",
					"make",
					"diff",
					"dockerfile",
					"lua",
					"luadoc",
					"nginx",
					"markdown",
					"markdown_inline",
					"yaml",
					"html",
					"css",
					"http",
					"json",
					"javascript",
					"typescript",
					"python",
					-- "angular",
					"sql",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },

				-- easier navigation of textObjects
				-- TODO: learn how to use advanced text objects mapping
				-- either in vanilla vim or using tree-sitter syntax mapping(ac,ic,af,if)
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Enter>", -- set to `false` to disable one of the mappings
						node_incremental = "<Enter>",
						scope_incremental = false,
						node_decremental = "<Backspace>",
					},
				},
			})

			-- inspect tree sitter syntax easily
			vim.keymap.set("n", "<leader>ci", "<cmd>:InspectTree<CR>", { desc = "[c]ode [i]nspect tree-sitter" })

			-- attach to file
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	-- lightning fast auto-completion
	{
		"saghen/blink.cmp",
		-- enabled=false,
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.6.0",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			keymap = {
				preset = "default",
				-- use tabs to auto-complete alongside default settings
				-- ["<Tab>"] = { "accept", "fallback" },
				-- ["<C-k>"] = { "select_prev", "fallback" },
				-- ["<C-j>"] = { "select_next", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = true },
				-- removed ghost text. too distracting
				-- ghost_text = { enabled = true },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- entirely from kickstart nvim
	{

		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		tag = "v2.0.0",
		-- enabled = false,
		dependencies = {
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			-- NOTE: had to tag the versions since Neovim 0.11 has built in lsp support and
			-- introduces breaking changes in most plugins
			{ "mason-org/mason.nvim", tag = "v1.11.0", opts = {} },
			{ "mason-org/mason-lspconfig.nvim", tag = "v1.32.0" },
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>cn", vim.lsp.buf.rename, "[c]hange [n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gi", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gt", require("telescope.builtin").lsp_type_definitions, "[g]oto [t]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			local servers = {
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				bashls = {}, -- bash
				lua_ls = {}, -- lua
				clangd = {}, -- c/c++
				html = {}, -- html
				cssls = {}, -- css
				jsonls = {}, -- json
				yamlls = {}, -- yaml
				basedpyright = {}, -- python
				ts_ls = {}, -- javascript, typescript
				dockerls = {}, -- docker
				docker_compose_language_service = {}, -- docker compose
				sqlls = {}, -- sql
				taplo = {}, -- tomml
			}

			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"prettier", -- format js and ts code
				"prettierd", -- format js and ts code, but running on a dedicated daemon
				"black", -- format python code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- see what error message is about with lsp
			vim.keymap.set("n", "ge", function()
				vim.diagnostic.open_float()
			end, { desc = "LSP: [g]oto [e]rror diagnostics" })
		end,
	},

	-- manage all your code formatters from a single place, e.g prettier,black
	{
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
				markdown = { "prettier" },
			},
		},
		-- format using key bindings
		vim.keymap.set("n", "<leader>cf", function()
			require("conform").format({ lsp_format = "fallback", async = true })
			print("File formatted")
		end, { desc = "[c]ode [f]ormat" }),
	},

	-- autopairs for {,[,(,",',`
	{
		"windwp/nvim-autopairs",
		-- enabled = false,
		event = "InsertEnter",
		config = true,
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
}
