-- read hex files easily

return {
	"RaafatTurki/hex.nvim",
	-- enable=false,
	config = function()
		require("hex").setup({})
	end,
}
