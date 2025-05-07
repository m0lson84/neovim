--[[
hadolint (https://github.com/hadolint/hadolint)
--]]

return {
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      linters = {
        erb_lint = {},
      },
    },
  },
}
