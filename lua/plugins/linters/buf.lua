--[[
Buf (https://buf.build/)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        buf_ls = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        buf = {},
      },
    },
  },
}
