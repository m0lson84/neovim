--[[
goimports (https://pkg.go.dev/golang.org/x/tools/cmd/goimports)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'goimports' }
    }
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        goimports = {},
      },
    },
  },
}
