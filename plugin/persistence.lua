--[[
persistence.nvim (https://github.com/folke/persistence.nvim)
--]]

vim.pack.add({ 'https://github.com/folke/persistence.nvim' })

require('persistence').setup({})

vim.keymap.set(
  'n',
  '<leader>pd',
  function() require('persistence').stop() end,
  { desc = '[d]on\'t save current session' }
)
vim.keymap.set(
  'n',
  '<leader>pl',
  function() require('persistence').load({ last = true }) end,
  { desc = 'restore [l]ast session' }
)
vim.keymap.set('n', '<leader>pr', function() require('persistence').load() end, { desc = '[r]estore session' })
vim.keymap.set('n', '<leader>ps', function() require('persistence').select() end, { desc = 'select [s]ession' })
