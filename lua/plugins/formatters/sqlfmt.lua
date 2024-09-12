--[[
sqlfmt (https://sqlfmt.com/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'sqlfmt' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        sqlfmt = {},
      },
    },
  },
}
