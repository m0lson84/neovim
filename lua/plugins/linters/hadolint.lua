--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'hadolint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        hadolint = {},
      },
    },
  },
}
