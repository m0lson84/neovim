--[[
Typst language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'typst' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      settings = {
        tinymist = {
          formatterMode = 'typstyle',
        },
      },
      servers = {
        tinymist = {},
      },
    },
  },

  -- Document preview
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
