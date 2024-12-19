--[[
nvim-treesitter-context
--]]

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
      enabled = true,
      mode = 'cursor',
      max_lines = 3,
    },
  },
}
