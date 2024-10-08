--[[
trouble.nvim (https://github.com/folke/trouble.nvim)
--]]

return {
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      defaults = {
        get_selection_window = function()
          require('edgy').goto_main()
          return 0
        end,
      },
      modes = {
        lsp = {
          win = { position = 'bottom' },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'diagnostics (trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'buffer diagnostics (trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = '[s]ymbols (trouble)' },
      { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'lsp references/definitions/... (trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = '[L]ocation list (trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = '[Q]uickfix list (trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },
}
