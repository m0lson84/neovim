--[[
sidekick.nvim (https://github.com/folke/sidekick.nvim)
--]]

--- Input a prompt to send to ai agent
local function input_prompt()
  return function()
    local msg = vim.fn.input('Ask agent: ')
    if not msg or msg == '' then return end
    require('sidekick.cli').send({ msg = ' ' .. msg })
  end
end

--- Select prompt to send to ai agent.
local function select_prompt()
  return function() require('sidekick.cli').prompt() end
end

--- Toggle ai agent interface.
---@param name string? The name of the agent
---@return function handler The keymap handler function.
local function toggle_cli(name)
  vim.diagnostic.get()
  return function() require('sidekick.cli').toggle({ name = name, focus = true }) end
end

return {
  {
    'folke/sidekick.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {
      nes = { enabled = false },
      cli = {
        mux = {
          enabled = true,
          backend = 'zellij',
        },
      },
    },
    keys = {
      { '<leader>aa', input_prompt(), mode = { 'n', 'v' }, desc = '[a]sk opencode' },
      { '<leader>ap', select_prompt(), desc = 'select [p]rompt' },
      { '<leader>at', toggle_cli('opencode'), desc = '[t]oggle opencode' },
    },
  },
}
