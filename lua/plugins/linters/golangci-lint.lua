--[[
golangci-lint (https://golangci-lint.run)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'golangci-lint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters = {
        golangcilint = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        ['golangci-lint'] = {},
      },
    },
  },
}
