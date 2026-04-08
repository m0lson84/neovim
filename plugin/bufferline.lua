--[[
bufferline.nvim (https://github.com/akinsho/bufferline.nvim)
--]]

local icons = require('config.icons')

vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })

local bufferline = require('bufferline')
bufferline.setup({
  options = {
    close_command = function(n) Snacks.bufdelete(n) end,
    right_mouse_command = function(n) Snacks.bufdelete(n) end,
    indicator = { style = 'none' },
    buffer_close_icon = '󰖭',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diag)
      local ret = (diag.error and icons.diagnostics.Error .. diag.error .. ' ' or '')
        .. (diag.warning and icons.diagnostics.Error .. diag.warning or '')
      return vim.trim(ret)
    end,
    get_element_icon = function(opts) return icons.ft[opts.filetype] end,
    always_show_bufferline = false,
    hover = { enabled = true, delay = 100, reveal = { 'close' } },
    sort_by = 'relative_directory',
    groups = { items = { bufferline.groups.builtin.pinned:with({ icon = '' }) } },
  },
})

vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'toggle [p]in' })
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'delete non-[P]inned buffers' })
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'delete [o]ther buffers' })
vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'delete buffers to the [r]ight' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'delete buffers to the [l]eft' })
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'prev buffer' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'move buffer prev' })
vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'move buffer next' })
