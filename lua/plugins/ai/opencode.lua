--[[
opencode.nvim (https://github.com/NickvanDyke/opencode.nvim)
--]]

--- Input a prompt to send to opencode
---@param default? string Text to prefill the input with.
local function input_prompt(default)
  return function() require('opencode').ask(default) end
end

--- Create a new session
local function new_session()
  return function() require('opencode').command('session_new') end
end

--- Select prompt to send to opencode
local function select_prompt()
  return function() require('opencode').select() end
end

--- Toggle embedded opencode TUI
local function toggle_panel()
  return function() require('opencode').toggle() end
end

return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    opts = {},
    config = function(_, opts) vim.g.opencode_opts = opts or {} end,
    keys = {
      { '<leader>aa', input_prompt(), mode = { 'n' }, desc = '[a]sk opencode' },
      { '<leader>aa', input_prompt('@selection: '), mode = { 'v' }, desc = '[a]sk selection' },
      { '<leader>ap', select_prompt(), mode = { 'n', 'v' }, desc = 'select [p]rompt' },
      { '<leader>as', new_session(), desc = 'new [s]ession' },
      { '<leader>at', toggle_panel(), desc = '[t]oggle opencode' },
    },
  },
}
