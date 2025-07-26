
-- Highlight text for some time after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		vim.o.backupext = extension
	end,
})

-- python specific files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		vim.bo.tabstop = 4 -- TAB will be equal to 4 spaces
		vim.bo.softtabstop = 4 --insert/delete 4 spaces when hitting TAB/BACKSPACE
		vim.bo.shiftwidth = 4 -- operation >> & << will indent/unindent 4 columns
		vim.bo.textwidth = 79 -- lines longer than 79 chars are broken
		vim.bo.colorcolumn = "80" -- where right horizontal line margin will be showed
		vim.bo.expandtab = true -- inser spaces when hitting TAB
		vim.bo.autoindent = true -- align new line indentation with previous line
		vim.bo.fileformat = "unix" -- format all files to have unix base EOF
	end,
})

-- nice border on snacks picker
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
