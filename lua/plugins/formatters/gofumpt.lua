--[[
gofumpt (https://github.com/mvdan/gofumpt)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'gofumpt' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        gofumpt = {},
      },
    },
  },
}
