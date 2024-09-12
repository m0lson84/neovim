--[[
StyLua (https://github.com/JohnnyMorganz/StyLua)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'stylua' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        stylua = {},
      },
    },
  },
}
