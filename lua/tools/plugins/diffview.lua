--[[
-- diffview.nvim (https://github.com/sindrets/diffview.nvim)
--]]

return {
  {
    'sindrets/diffview.nvim',
    lazy = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      enhanced_diff_hl = true,
    },
  },
}
