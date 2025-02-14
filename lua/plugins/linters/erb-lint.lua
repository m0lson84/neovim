--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'erb-lint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        erb_lint = {},
      },
    },
  },
}
