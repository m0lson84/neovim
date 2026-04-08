--[[
flash.nvim (https://github.com/folke/flash.nvim)
--]]

vim.pack.add({ 'https://github.com/folke/flash.nvim' })

require('flash').setup({})

vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'flash' })
vim.keymap.set({ 'n', 'o', 'x' }, 'S', function() require('flash').treesitter() end, { desc = 'flash (treesitter)' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'remote flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'search treesitter' })
vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end, { desc = 'toggle flash search' })
vim.keymap.set(
  { 'n', 'o', 'x' },
  '<c-space>',
  function()
    require('flash').treesitter({
      actions = {
        ['<c-space>'] = 'next',
        ['<BS>'] = 'prev',
      },
    })
  end,
  { desc = 'treesitter incremental selection' }
)
