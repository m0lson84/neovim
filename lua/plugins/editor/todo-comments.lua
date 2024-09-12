--[[
todo-comments.nvim (https://github.com/folke/todo-comments.nvim)
--]]

return {
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoFzfLua' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
    keys = {
      { ']t', function() require('todo-comments').jump_next() end, desc = 'next todo comment' },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'previous todo comment' },
      { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = '[t]odo (trouble)' },
      {
        '<leader>xT',
        '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
        desc = '[T]odo/fix/fixme (trouble)',
      },
      { '<leader>st', '<cmd>TodoFzfLua<cr>', desc = '[t]odo' },
      { '<leader>sT', '<cmd>TodoFzfLua keywords=TODO,FIX,FIXME<cr>', desc = '[T]odo/fix/fixme' },
    },
  },
}
