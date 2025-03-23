--[[
grug-far.nvim
--]]

--- Search and replace
local search_and_replace = function()
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  require('grug-far').open({
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  })
end

--- Search within the current file
local search_in_file = function()
  require('grug-far').open({
    prefills = {
      paths = vim.fn.expand('%'),
    },
  })
end

return {
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      engine = 'ripgrep',
      transient = true,
    },
    keys = {
      { '<leader>sr', search_and_replace, mode = { 'n', 'v' }, desc = '[s]earch and [r]eplace' },
      { '<leader>sR', search_in_file, mode = { 'n', 'v' }, desc = '[s]earch / [R]eplace in file' },
    },
  },
}
