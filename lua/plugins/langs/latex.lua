--[[
LaTeX language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'bibtex' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        texlab = {},
      },
    },
  },

  -- Configure vimtex
  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.g.vimtex_mappings_enabled = 0
      vim.g.vimtex_quickfix_method = vim.fn.executable('pplatex') == 1 and 'pplatex' or 'latexlog'
    end,
  },
}
