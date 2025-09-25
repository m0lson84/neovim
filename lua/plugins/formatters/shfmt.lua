--[[
shfmt (https://github.com/patrickvane/shfmt)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'shfmt' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        shfmt = {
          prepend_args = function(_, ctx)
            local indent_size = vim.bo[ctx.buf].shiftwidth or 2
            return { '-i', string.format('%d', indent_size), '-ci' }
          end,
        },
      },
    },
  },
}
