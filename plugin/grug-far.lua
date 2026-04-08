--[[
grug-far.nvim (https://github.com/MagicDuck/grug-far.nvim)
--]]

vim.pack.add({ 'https://github.com/MagicDuck/grug-far.nvim' })

require('grug-far').setup({
  engine = 'ripgrep',
  transient = true,
})

vim.keymap.set({ 'n', 'v' }, '<leader>sr', function()
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  require('grug-far').open({
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  })
end, { desc = '[s]earch and [r]eplace' })
vim.keymap.set(
  { 'n', 'v' },
  '<leader>sR',
  function()
    require('grug-far').open({
      prefills = {
        paths = vim.fn.expand('%'),
      },
    })
  end,
  { desc = '[s]earch / [R]eplace in file' }
)
