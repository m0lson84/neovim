--[[
markdownlint (https://github.com/DavidAnson/markdownlint)
--]]

return {

  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'markdownlint-cli2' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      linters = {
        ['markdownlint-cli2'] = {
          args = { '--config', vim.fn.expand('~/.config/nvim/config/.markdownlint.json') },
        },
      },
    },
  },
}
