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
    opts = {
      formatters = {
        templ = {},
      },
    },
  },
}
