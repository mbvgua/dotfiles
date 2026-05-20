-- debugging in various langs. also entirely from kickstart
local map = vim.keymap.set

return {
	"mfussenegger/nvim-dap",
	version = "v0.10.0",
	-- enabled=false,
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- mason nvim dap
		require("mason-nvim-dap").setup({
			-- setup the various debuggers with reasonable default configurations
			automatic_installation = true,
			-- see mason-nvim-dap README
			handlers = {},
			ensure_installed = {
				-- debuggers for the langs you want
				"python",
				"js",
				"bash",
				"cppdbg",
			},
		})

		-- Dap UI setup
		dapui.setup({
			-- NOTE: better arrangement when i uncomment this. find out why?
			-- icons = { expanded = "▾", collapsed = "▸" },
			-- mappings = {
			-- 	open = "o",
			-- 	remove = "d",
			-- 	edit = "e",
			-- 	repl = "r",
			-- 	toggle = "t",
			-- },
			-- expand_lines = vim.fn.has("nvim-0.7"),
			-- layouts = {
			-- 	{
			-- 		elements = {
			-- 			"scopes",
			-- 		},
			-- 		size = 0.3,
			-- 		position = "right",
			-- 	},
			-- 	{
			-- 		elements = {
			-- 			"repl",
			-- 			"breakpoints",
			-- 		},
			-- 		size = 0.3,
			-- 		position = "bottom",
			-- 	},
			-- },
			-- floating = {
			-- 	max_height = nil,
			-- 	max_width = nil,
			-- 	border = "single",
			-- 	mappings = {
			-- 		close = { "q", "<Esc>" },
			-- 	},
			-- },
			-- windows = { indent = 1 },
			-- render = {
			-- 	max_type_length = nil,
			-- },
		})

		-- dap virtual text setup
		dap_virtual_text.setup({
			commented = true, -- Show virtual text alongside comment
			virt_text_win_col = 80, -- position the virtual text at a fixed window column
			show_stop_reason = true, -- show stop reason when stopped for exceptions
		})

		-- Change breakpoint icons
		vim.fn.sign_define("DapBreakpoint", {
			text = "🐞",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "",
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		})

		-- Automatically open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- keybinds
		-- core stepping
		map("n", "<leader>ds", function() dap.continue() end, { desc = "continue/[s]tart dap debugging" })
		map("n", "<leader>du", function() dapui.toggle() end, { desc = "toggle dap [u]i" })
		map("n", "<leader>do", function() dap.step_over() end, { desc = "dap step [o]ver" })
		map("n", "<leader>di", function() dap.step_into() end, { desc = "dap step [i]nto" })
		map("n", "<leader>dt", function() dap.step_out() end, { desc = "dap step ou[t]" })

		-- breakpoints
		map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "toggle dap [b]reakpoint" })
		map("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Condition: "))
		end, { desc = "set conditional [B]reakpoint" })
		map("n", "<leader>dc", function()
			dap.clear_breakpoints()
			vim.notify("Breakpoints cleared", "INFO")
		end, { desc = "dap [c]lear breakpoints" })

		-- evaluate in repl
		map("n", "<leader>de", function()
			vim.ui.input({ prompt = "Evaluate expression: " }, function(expr)
				if expr then
					require("dap").repl.execute(expr)
				end
			end)
		end, { desc = "evaluate [e]xpression" })

		-- exit debugger
		map("n", "<leader>dq", function()
			dap.clear_breakpoints()
			dap.terminate()
			vim.notify("debugger session ended", "WARN")
		end, { desc = "[q]uit dap debugging" })
	end,
}
