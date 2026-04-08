--[[
blink.cmp (https://github.com/saghen/blink.cmp)
--]]

vim.schedule(function()
  vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = 'v1' },
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/saghen/blink.compat',
    'https://github.com/fang2hou/blink-copilot',
  })

  require('blink.compat').setup({})

  require('blink.cmp').setup({
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      menu = {
        border = 'rounded',
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev' },
      providers = {
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          async = true,
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    signature = {
      enabled = true,
    },
    keymap = {
      preset = 'default',
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
    },
  })
end)
