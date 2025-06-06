--[[
SQLFluff (https://sqlfluff.com/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'sqlfluff' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters = {
        sqlfluff = { args = { 'lint', '--format=json' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        sqlfluff = { args = { 'fix', '-' } },
      },
    },
  },
}
