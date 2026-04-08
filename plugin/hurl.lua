--[[
hurl.nvim (https://github.com/jellydn/hurl.nvim)
--]]

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'hurl',
  once = true,
  callback = function()
    vim.pack.add({
      'https://github.com/jellydn/hurl.nvim',
      'https://github.com/MunifTanjim/nui.nvim',
    })
    require('hurl').setup({
      debug = true,
      mode = 'split',
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'hurl',
  callback = function(args)
    local buf = args.buf
    vim.keymap.set('n', '<leader>ha', '<cmd>HurlRunner<cr>', { buf = buf, desc = 'execute [a]ll requests' })
    vim.keymap.set('n', '<leader>hr', '<cmd>HurlRunnerAt<cr>', { buf = buf, desc = 'execute selected [r]equest' })
    vim.keymap.set('n', '<leader>hv', '<cmd>HurlVerbose<cr>', { buf = buf, desc = 'execute in [v]erbose mode' })
    vim.keymap.set('n', '<leader>hl', '<cmd>HurlShowLastResposne<cr>', { buf = buf, desc = 'show [l]ast response' })
    vim.keymap.set('n', '<leader>ht', '<cmd>HurlToggleMode<cr>', { buf = buf, desc = '[t]oggle display mode' })
    vim.keymap.set('n', '<leader>hm', '<cmd>HurlManageVariable<cr>', { buf = buf, desc = '[m]anage environment' })
  end,
})
