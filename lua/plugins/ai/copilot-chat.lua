--[[
CopilotChat.nvim (https://github.com/CopilotC-Nvim/CopilotChat.nvim)
--]]

--- Start a quick chat session.
local quick_chat = function()
  vim.ui.input({ prompt = 'Quick Chat: ' }, function(input)
    if input ~= '' then require('CopilotChat').ask(input) end
  end)
end

--- Reset the current chat session.
local reset_current_chat = function() require('CopilotChat').reset() end

--- Select default model
local select_model = function() require('CopilotChat').select_model() end

--- Select prompt actions
local select_prompt = function() require('CopilotChat').select_prompt() end

--- Toggle chat display
local toggle_interface = function() require('CopilotChat').toggle() end

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = { 'zbirenbaum/copilot.lua' },
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.25,
        },
      }
    end,
    keys = {
      { '<leader>as', '', desc = '[s]elect' },
      { '<leader>ap', select_prompt, mode = { 'n', 'v' }, desc = '[p]rompt actions' },
      { '<leader>aq', quick_chat, mode = { 'n', 'v' }, desc = '[q]uick chat' },
      { '<leader>ar', reset_current_chat, mode = { 'n', 'v' }, desc = '[r]eset chat' },
      { '<leader>at', toggle_interface, mode = { 'n', 'v' }, desc = '[t]oggle chat' },
      { '<leader>asm', select_model, mode = { 'n', 'v' }, desc = '[m]odel' },
      { '<c-y>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
    },
    config = function(_, opts)
      local chat = require('CopilotChat')
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.wo.number = false
          vim.wo.relativenumber = false
          vim.wo.conceallevel = 0
        end,
      })

      chat.setup(opts)
    end,
  },
  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = 'copilot-chat',
        title = 'Copilot Chat',
        size = { width = 50 },
      })
    end,
  },
}
