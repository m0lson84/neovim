--[[
copilot.lua (https://github.com/zbirenbaum/copilot.lua)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {},
      },
    },
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      nes = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      { 'fang2hou/blink-copilot' },
    },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  {
    'AndreM222/copilot-lualine',
  },
}
