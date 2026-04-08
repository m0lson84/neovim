--[[
todo-comments.nvim (https://github.com/folke/todo-comments.nvim)
--]]

vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require('todo-comments').setup({})

vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'next todo comment' })
vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'previous todo comment' })
vim.keymap.set('n', '<leader>st', function() Snacks.picker['todo_comments']() end, { desc = '[t]odo' })
vim.keymap.set(
  'n',
  '<leader>sT',
  function() Snacks.picker['todo_comments']({ keywords = { 'FIX', 'FIXME', 'TODO' } }) end,
  { desc = '[T]odo/fix/fixme' }
)
vim.keymap.set('n', '<leader>xt', '<cmd>Trouble todo toggle<cr>', { desc = '[t]odo (trouble)' })
vim.keymap.set(
  'n',
  '<leader>xT',
  '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
  { desc = '[T]odo/fix/fixme (trouble)' }
)
