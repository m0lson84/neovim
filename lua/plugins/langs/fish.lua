--[[
Fish language support
--]]

return {
  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts) vim.list_extend(opts.ensure_installed or {}, { 'fish' }) end,
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        fish_lsp = {},
      },
    },
  },

  -- Configure linters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        fish = { 'fish' },
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        fish = { 'fish_indent' },
      },
    },
  },

  -- Filetype icons
  {
    'nvim-mini/mini.icons',
    opts = {
      extension = {
        fish = { glyph = '', hl = 'MiniIconsGrey' },
        ['fish.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
      },
    },
  },
}
