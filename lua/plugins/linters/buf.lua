--[[
Buf (https://buf.build/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'buf' },
    },
  },
  {
    'mfussenegger/nvim-lint',
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
        buf = {},
      },
    },
  },
}
