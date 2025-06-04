-- animate inactive windows and buffers

return {
  {
    'tadaa/vimade',
    -- enabled=false,
    opts = {
      recipe = { 'minimalist', { animate = false } },
      -- ncmode = 'windows' will fade inactive windows.
      ncmode = 'windows',
      fadelevel = 0.7,
  }
  }
}

