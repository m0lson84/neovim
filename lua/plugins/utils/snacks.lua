--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      bigfile = { enabled = true },
      notifier = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
