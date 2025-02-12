--[[
otter.nvim (https://github.com/jmbuhr/otter.nvim)
--]]

return {
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
}
