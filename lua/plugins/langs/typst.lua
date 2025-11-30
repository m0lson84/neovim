--[[
Typst language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'typst' },
    },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typst = { 'typstyle' },
      },
    },
  },

  -- Document preview
  {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '1.*',
    opts = {
      dependencies_bin = {
        tinymist = 'tinymist',
      },
    },
    keys = {
      { '<leader>cp', '<cmd>TypstPreview<cr>', ft = 'typst', desc = '[p]review doc' },
    },
  },
}
