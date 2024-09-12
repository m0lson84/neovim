--[[
bufferline.nvim (https://github.com/akinsho/bufferline.nvim)
--]]

return {
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'toggle [p]in' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'delete non-[P]inned buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'delete [o]ther buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'delete buffers to the [r]ight' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'delete buffers to the [l]eft' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'prev buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'next buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'prev buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'next buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'move buffer next' },
    },
    opts = function()
      local bufferline = require('bufferline')
      return {
        options = {
          close_command = function(n) utils.ui.bufremove(n) end,
          right_mouse_command = function(n) utils.ui.bufremove(n) end,
          indicator = { style = 'none' },
          buffer_close_icon = '󰖭',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, _, diag)
            local icons = config.icons.diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
              .. (diag.warning and icons.Error .. diag.warning or '')
            return vim.trim(ret)
          end,
          offsets = {
            { filetype = 'neo-tree', separator = true },
            { filetype = 'neotest-summary', separator = true },
          },
          get_element_icon = function(opts) return config.icons.ft[opts.filetype] end,
          always_show_bufferline = false,
          hover = { enabled = true, delay = 100, reveal = { 'close' } },
          sort_by = 'relative_directory',
          groups = { items = { bufferline.groups.builtin.pinned:with({ icon = '' }) } },
        },
      }
    end,
  },
}
