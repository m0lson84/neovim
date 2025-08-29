--[[
typstyle (https://typstyle-rs.github.io/typstyle/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'typstyle' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        typstyle = {
          args = function(_, ctx)
            local line_length = vim.bo[ctx.buf].textwidth or 120
            return { '--wrap-text', '-l', tostring(line_length), ctx.filename }
          end,
        },
      },
    },
  },
}
