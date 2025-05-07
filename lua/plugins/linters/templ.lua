--[[
templ (https://github.com/a-h/templ)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'templ' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason.nvim' },
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
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        templ = {},
      },
    },
  },
}
