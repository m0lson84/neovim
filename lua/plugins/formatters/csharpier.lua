--[[
csharpier (https://csharpier.com)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'csharpier' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        csharpier = {
          command = 'dotnet',
          args = { 'csharpier', 'format', '--write-stdout' },
          stdin = true,
        },
      },
    },
  },
}
