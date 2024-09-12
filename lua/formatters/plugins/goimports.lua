--[[
goimports (https://pkg.go.dev/golang.org/x/tools/cmd/goimports)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'goimports' }
    }
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        goimports = {},
      },
    },
  },
}
