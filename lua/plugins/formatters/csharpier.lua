--[[
csharpier (https://csharpier.com)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'csharpier' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        csharpier = {},
      },
    },
  },
}
