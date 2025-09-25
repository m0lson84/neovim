--[[
Prettier (https://prettier.io/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'prettierd' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        graphql = { 'prettierd' },
        handlebars = { 'prettierd' },
        less = { 'prettierd' },
        vue = { 'prettierd' },
      },
    },
  },
}
