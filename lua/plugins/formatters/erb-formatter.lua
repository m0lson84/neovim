--[[
erb-formatter (https://github.com/nebulab/erb-formatter)
--]]

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        erb_format = {
          prepend_args = function(_, ctx)
            local line_length = vim.bo[ctx.buf].textwidth or 120
            return { '--print-width', string.format('%d', line_length) }
          end,
        },
      },
    },
  },
}
