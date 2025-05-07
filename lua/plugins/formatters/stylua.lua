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
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        stylua = {},
      },
    },
  },
}
