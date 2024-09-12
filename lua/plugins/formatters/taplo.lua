--[[
taplo (https://taplo.tamasfe.dev/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'taplo' } },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      formatters = {
        taplo = {
          args = function(_, ctx)
            local line_length = vim.bo[ctx.buf].textwidth or 120
            return {
              'format',
              '--option',
              string.format('column_width=%d', line_length),
              '--option',
              'align_entries=true',
              '--option',
              'reorder_keys=true',
              '--option',
              'reorder_arrays=true',
              '-',
            }
          end,
        },
      },
    },
  },
}
