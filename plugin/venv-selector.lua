--[[
venv-selector.nvim (https://github.com/linux-cultist/venv-selector.nvim)
--]]

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/linux-cultist/venv-selector.nvim' })
    require('venv-selector').setup({})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    vim.keymap.set('n', '<leader>cv', '<cmd>:VenvSelect<cr>', { buf = args.buf, desc = 'Select VirtualEnv' })
  end,
})
