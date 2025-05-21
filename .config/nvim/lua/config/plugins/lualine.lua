return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      always_divide_middle = true,
      always_show_tabline = true,
      -- only 1 statusline for all windows/buffers
      globalstatus = true
    },
    sections = {
      lualine_a = { { 'mode', separator = { left = '', right = '' } } },
      lualine_b = {
        { 'branch', icon = '' },
        {
          'diff', symbols = { added = ' ', modified = ' ', removed = ' ' }
        },
      },
      lualine_c = {
        { 'diagnostics' },
        {
          'filename',
          newfile_status = true,
          symbols = {
            modified = '', readonly = '', unnamed = '', newfile = ''
          }
        },
      },
      -- TODO: add the LSP ICON here instead of search count
      lualine_x = { ' ' },
      lualine_y = {
        { 'filetype', icon = { align = 'right' } },
        'fileformat',
      },
      lualine_z = {
        {
          -- show line of code in file, like Vim. but proved quite hard
          -- TODO: make this more readable later on, quite hard
          -- still works like: '%l/%L' in vim statusline
          -- . -> current line no. $ -> total lines
          function()
            return 'LOC: ' .. vim.fn.line('.') .. '/' .. vim.fn.line('$')
          end,
        },
        { 'progress', separator = { left = '', right = '' } }
      }
    },
  }
}
