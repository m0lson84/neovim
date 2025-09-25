--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'erb-lint' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters = {
        erb_lint = {},
      },
    },
  },
}
