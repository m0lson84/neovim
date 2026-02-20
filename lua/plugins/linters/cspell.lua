--[[
CSpell (https://cspell.org/)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        cspell_ls = {},
      },
    },
  },
}
