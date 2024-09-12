--[[
gofumpt (https://github.com/mvdan/gofumpt)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'gofumpt' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        gofumpt = {},
      },
    },
  },
}
