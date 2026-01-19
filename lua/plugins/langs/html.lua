--[[
HTML language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'html', 'templ' },
    },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        html = {},
        templ = {},
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        html = { 'prettierd' },
        templ = { 'templ', 'injected' },
      },
    },
  },
}
