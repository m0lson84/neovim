--[[
Prettier (https://prettier.io/)
--]]

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = { 'prettierd' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = function(_, opts)
      opts.formatters_by_ft = utils.table.extend_keys(
        opts.formatters_by_ft,
        { 'graphql', 'handlebars', 'less', 'vue' },
        { 'prettierd' }
      )
    end,
  },
}
