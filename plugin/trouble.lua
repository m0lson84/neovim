--[[
trouble.nvim (https://github.com/folke/trouble.nvim)
--]]

vim.pack.add({ 'https://github.com/folke/trouble.nvim' })

require('trouble').setup({
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
})

vim.keymap.set('n', ']q', function()
  if require('trouble').is_open() then
    require('trouble').next({ skip_groups = true, jump = true })
    return
  end
  local ok, err = pcall(vim.cmd.cnext)
  if not ok then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Next Trouble/Quickfix Item' })

vim.keymap.set('n', '[q', function()
  if require('trouble').is_open() then
    require('trouble').prev({ skip_groups = true, jump = true })
    return
  end
  local ok, err = pcall(vim.cmd.cprev)
  if not ok then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Previous Trouble/Quickfix Item' })

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'diagnostics (trouble)' })
vim.keymap.set(
  'n',
  '<leader>xX',
  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'buffer diagnostics (trouble)' }
)
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle<cr>', { desc = '[s]ymbols (trouble)' })
vim.keymap.set('n', '<leader>cS', '<cmd>Trouble lsp toggle<cr>', { desc = 'lsp references/definitions/... (trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = '[L]ocation list (trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = '[Q]uickfix list (trouble)' })
