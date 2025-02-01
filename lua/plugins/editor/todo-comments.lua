--[[
todo-comments.nvim (https://github.com/folke/todo-comments.nvim)
--]]

---Open a picker for desired comments
---@param opts table | nil The options to pass to the picker.
local function pick(opts)
  return function() Snacks.picker['todo_comments'](opts) end
end

return {
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
    keys = {
      { ']t', function() require('todo-comments').jump_next() end, desc = 'next todo comment' },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'previous todo comment' },
      { '<leader>st', pick(), desc = '[t]odo' },
      { '<leader>sT', pick({ keywords = { 'FIX', 'FIXME', 'TODO' } }), desc = '[T]odo/fix/fixme' },
      { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = '[t]odo (trouble)' },
      {
        '<leader>xT',
        '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
        desc = '[T]odo/fix/fixme (trouble)',
      },
    },
  },
}
