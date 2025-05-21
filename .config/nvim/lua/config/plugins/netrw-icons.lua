-- display nice file/directory icons when browsing with netrw

return{
    'prichrd/netrw.nvim',
    -- enabled=false,
    config = function()
        require('netrw').setup({
            use_devicons = true, 
        })

    end,
}

