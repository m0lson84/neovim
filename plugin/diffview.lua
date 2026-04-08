--[[
diffview.nvim (https://github.com/sindrets/diffview.nvim)
--]]

vim.schedule(function()
  vim.pack.add({ 'https://github.com/sindrets/diffview.nvim' })
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
end)
