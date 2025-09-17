local vim = vim or {}

-- meta accessors for vim autocmds
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local hl = vim.api.nvim_set_hl
local bo = vim.bo
local wo = vim.wo
local o = vim.o

-- Highlight text for some time after yanking
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})

-- Append backup files with timestamp
autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		o.backupext = extension
	end,
})

-- formatting for python specific files
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		bo.tabstop = 4 -- TAB will be equal to 4 spaces
		bo.softtabstop = 4 --insert/delete 4 spaces when hitting TAB/BACKSPACE
		bo.shiftwidth = 4 -- operation >> & << will indent/unindent 4 columns
		bo.textwidth = 79 -- lines longer than 79 chars are broken
		wo.colorcolumn = "80" -- where right horizontal line margin will be showed
		bo.expandtab = true -- inser spaces when hitting TAB
		bo.autoindent = true -- align new line indentation with previous line
		bo.fileformat = "unix" -- format all files to have unix base EOF
	end,
})

-- nice border on snacks picker
hl(0, "NormalFloat", { bg = "none" })
hl(0, "FloatBorder", { bg = "none" })
