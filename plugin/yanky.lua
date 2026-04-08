--[[
yanky.nvim (https://github.com/gbprod/yanky.nvim)
--]]

vim.pack.add({ 'https://github.com/gbprod/yanky.nvim' })

require('yanky').setup({
  highlight = { timer = 150 },
})

vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'yank text' })
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'put text after cursor' })
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'put text before cursor' })
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'put text after selection' })
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'put text before selection' })
vim.keymap.set('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'cycle forward through yank history' })
vim.keymap.set('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'cycle backward through yank history' })
vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'put indented after cursor (linewise)' })
vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'put indented before cursor (linewise)' })
vim.keymap.set('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'put indented after cursor (linewise)' })
vim.keymap.set('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'put indented before cursor (linewise)' })
vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)', { desc = 'put and indent right' })
vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', { desc = 'put and indent left' })
vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', { desc = 'put before and indent right' })
vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', { desc = 'put before and indent left' })
vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterFilter)', { desc = 'put after applying a filter' })
vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeFilter)', { desc = 'put before applying a filter' })
