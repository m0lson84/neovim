--[[
StyLua (https://github.com/JohnnyMorganz/StyLua)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'stylua' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        stylua = {},
      },
    },
  },
}
