--[[
diffview.nvim (https://github.com/sindrets/diffview.nvim)
--]]

vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
})

vim.schedule(function()
  require('diffview').setup({
    enhanced_diff_hl = true,
  })
end)
