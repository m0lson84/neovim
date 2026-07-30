--[[
kulala.nvim (https://github.com/mistweaverco/kulala.nvim)
--]]

vim.pack.add({
  'https://github.com/mistweaverco/kulala.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

vim.schedule(function()
  require('kulala').setup({})

  vim.keymap.set('n', '<leader>hs', function() require('kulala').scratchpad() end, { desc = 'open [s]cratchpad' })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'http', 'kulala_ui' },
    callback = function(args)
      local buf = args.buf
      vim.keymap.set(
        'n',
        '<leader>hr',
        function() require('kulala').run() end,
        { buffer = buf, desc = 'execute [r]equest' }
      )
      vim.keymap.set(
        'n',
        '<leader>hn',
        function() require('kulala').jump_next() end,
        { buffer = buf, desc = 'jump to [n]ext request' }
      )
      vim.keymap.set(
        'n',
        '<leader>hp',
        function() require('kulala').jump_prev() end,
        { buffer = buf, desc = 'jump to [p]revious request' }
      )
      vim.keymap.set(
        'n',
        '<leader>ho',
        function() require('kulala').open_openapi_explorer() end,
        { buffer = buf, desc = 'open [o]penapi explorer' }
      )
      vim.keymap.set(
        'n',
        '<leader>he',
        function() require('kulala').set_selected_env() end,
        { buffer = buf, desc = 'set selected [e]nvironment' }
      )
    end,
  })
end)
