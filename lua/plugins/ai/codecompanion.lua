--[[
CodeCompanion.nvim (https://github.com/olimorris/codecompanion.nvim)
--]]

return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'copilot',
        },
      },
      log_level = 'DEBUG',
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
    keys = {
      { '<leader>ai', '<cmd>CodeCompanion<cr>', desc = '[i]line assistant' },
      { '<leader>ap', '<cmd>CodeCompanionActions<cr>', desc = 'actions [p]alette' },
      { '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[t]oggle chat' },
    },
  },
}
