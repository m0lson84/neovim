--[[
Prettier (https://prettier.io/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'prettierd' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = function(_, opts)
      opts.formatters_by_ft = utils.table.extend_keys(
        opts.formatters_by_ft,
        { 'css', 'graphql', 'handlebars', 'html', 'less', 'scss', 'vue' },
        { 'prettierd' }
      )
    end,
  },
}