--[[
shfmt (https://github.com/patrickvane/shfmt)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'shfmt' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        shfmt = { prepend_args = { '-i', '2', '-ci' } },
      },
    },
  },
}
