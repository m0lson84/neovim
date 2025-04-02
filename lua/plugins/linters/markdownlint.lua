--[[
markdownlint (https://github.com/DavidAnson/markdownlint)
--]]

return {

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'markdownlint-cli2' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        ['markdownlint-cli2'] = {
          args = { '--config', vim.fn.expand('~/.config/nvim/config/.markdownlint.json') },
        },
      },
    },
  },
}
