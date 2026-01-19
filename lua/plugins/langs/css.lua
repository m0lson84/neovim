--[[
CSS language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'css', 'scss' },
    },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        cssls = {},
        tailwindcss = {},
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        css = { 'prettierd' },
        scss = { 'prettierd' },
      },
    },
  },
}
