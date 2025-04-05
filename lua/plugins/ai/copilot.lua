--[[
copilot.lua (https://github.com/zbirenbaum/copilot.lua)
--]]

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    keys = {
      { '<leader>aa', '<cmd>Copilot auth<cr>', desc = '[a]uthenticate' },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'giuxtaposition/blink-cmp-copilot' },
    },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
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
