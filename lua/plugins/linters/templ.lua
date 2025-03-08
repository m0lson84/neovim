--[[
templ (https://github.com/a-h/templ)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'templ' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      servers = {
        templ = {
          settings = {
            enable_snippets = true,
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        templ = {},
      },
    },
  },
}
