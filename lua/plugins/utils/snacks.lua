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
    },
  },
}
