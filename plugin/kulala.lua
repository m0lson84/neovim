--[[
kulala.nvim (https://github.com/mistweaverco/kulala.nvim)
--]]

local initialized = false
local function ensure_init()
  if initialized then return end
  initialized = true
  vim.pack.add({
    'https://github.com/mistweaverco/kulala.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  })
  require('kulala').setup({})
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  callback = function(args)
    ensure_init()
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
      '<leader>hv',
      function() require('kulala').toggle_view() end,
      { buffer = buf, desc = 'toggle response [v]iew' }
    )
    vim.keymap.set(
      'n',
      '<leader>he',
      function() require('kulala').set_selected_env() end,
      { buffer = buf, desc = 'set selected [e]nvironment' }
    )
  end,
})

vim.keymap.set('n', '<leader>hs', function()
  ensure_init()
  require('kulala').scratchpad()
end, { desc = 'open [s]cratchpad' })
