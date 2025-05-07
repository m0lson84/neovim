--[[
sqlfmt (https://sqlfmt.com/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'sqlfmt' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        sqlfmt = {},
      },
    },
  },
}
