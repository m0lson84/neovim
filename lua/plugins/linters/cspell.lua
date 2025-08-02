--[[
CSpell (https://cspell.org/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'cspell-lsp' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      servers = {
        cspell_lsp = {},
      },
    },
  },
}
