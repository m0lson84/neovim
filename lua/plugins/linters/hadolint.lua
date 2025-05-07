--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'hadolint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      linters = {
        hadolint = {},
      },
    },
  },
}
