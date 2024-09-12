--[[
CSpell (https://cspell.org/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'cspell' }
    }
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        cspell = {},
      },
      linters_by_ft = {
        ['*'] = { 'cspell' },
      },
    },
  },
}
