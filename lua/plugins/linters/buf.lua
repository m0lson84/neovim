--[[
Buf (https://buf.build/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'buf' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        buf_lint = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        ['buf'] = {},
      },
    },
  },
}
