--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      indent = { enabled = true },
      notifier = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
  },
}
