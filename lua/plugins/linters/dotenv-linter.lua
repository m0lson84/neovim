--[[
dotenv-linter (https://dotenv-linter.github.io/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'dotenv-linter' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters = {
        dotenv_linter = {},
      },
    },
  },
}
