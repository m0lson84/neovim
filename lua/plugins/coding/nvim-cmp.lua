--[[
nvim-cmp (https://github.com/hrsh7th/nvim-cmp)
--]]

return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'garymjr/nvim-snippets',
      'zbirenbaum/copilot-cmp',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        auto_brackets = {},
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete({}),
        }),
        snippet = {
          expand = function(args) vim.snippet.expand(args.body) end,
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'copilot', group_index = 1, priority = 100 },
          { name = 'snippets' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end,
  },
  {
    'garymjr/nvim-snippets',
    lazy = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      friendly_snippets = true,
    },
  },
}
