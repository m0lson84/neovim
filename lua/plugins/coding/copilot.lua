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
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = 'copilot.lua',
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require('copilot_cmp')
      copilot_cmp.setup(opts)
      utils.lsp.on_attach(function(_) copilot_cmp._on_insert_enter({}) end, 'copilot')
    end,
  },
}
