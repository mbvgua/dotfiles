-- autopairs for {,[,(,",',`

return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
      disable_filetype = { "TelescopePrompt" , "vim" },
    }
  }
}

