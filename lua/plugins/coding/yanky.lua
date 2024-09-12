--[[
yanky.nvim (https://github.com/gbprod/yanky.nvim)
--]]

return {
  {
    'gbprod/yanky.nvim',
    recommended = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      highlight = { timer = 150 },
    },
    keys = {
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'yank text' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'put text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'put text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'put text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'put text before selection' },
      { '[y', '<Plug>(YankyCycleForward)', desc = 'cycle forward through yank history' },
      { ']y', '<Plug>(YankyCycleBackward)', desc = 'cycle backward through yank history' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'put indented before cursor (linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'put and indent right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'put and indent left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'put before and indent right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'put before and indent left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'put before applying a filter' },
    },
  },
}
