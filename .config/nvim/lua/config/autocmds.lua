-- meta accessors for autocmds
local vim = vim or {}
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local cmd = vim.cmd
local bo = vim.bo
local opt = vim.opt

-- Highlight text for some time after yanking
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
	desc = "Highlight when yanking text",
})

-- Append backup files with timestamp
autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		opt.backupext = extension
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
		opt.colorcolumn = "80" -- where right horizontal line margin will be showed
		bo.expandtab = true -- inser spaces when hitting TAB
		bo.autoindent = true -- align new line indentation with previous line
		bo.fileformat = "unix" -- format all files to have unix base EOF
	end,
})

-- wrap and check for spelling automatically in text filetypes
autocmd("FileType", {
	group = augroup("wrap_spell", { clear = true }),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- recall and go to last LOC when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("LastLoc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit", "commit", "gitrebase" }
        local ft = vim.bo[event.buf].filetype

        -- Check if the current filetype is in the exclude list
        if vim.tbl_contains(exclude, ft) then
            return
        end

        -- Retrieve the mark for the last known cursor position
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(event.buf)

        -- If the mark is valid (line 1 or greater) and within the file's line count
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- make terminal navigation much easier
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	map("t", "<esc>", [[<C-\><C-n>]], opts)
	map("t", "jk", [[<C-\><C-n>]], opts)
	map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
