--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
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
