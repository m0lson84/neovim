--[[
opencode.nvim (https://github.com/NickvanDyke/opencode.nvim)
--]]

--- Input a prompt to send to opencode
---@param default? string Text to prefill the input with.
local function ask_prompt(default)
  return function() require('opencode').ask(default) end
end

--- Create a new session
local function new_session()
  return function() require('opencode').command('session.new') end
end

--- Select prompt to send to opencode
local function select_prompt()
  return function() require('opencode').select() end
end

--- Attach to a running opencode server
local function select_server()
  return function() require('opencode').select_server() end
end

--- Toggle embedded opencode TUI
local function toggle_panel()
  return function() require('opencode').toggle() end
end

return {
  {
    'nickjvandyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    opts = {},
    config = function(_, opts)
      vim.g.opencode_opts = opts or {}
      vim.o.autoread = true
    end,
    keys = {
      { '<leader>aa', ask_prompt('@buffer '), mode = { 'n' }, desc = '[a]sk opencode' },
      { '<leader>aa', ask_prompt('@this: '), mode = { 'v' }, desc = '[a]sk selection' },
      { '<leader>ap', select_prompt(), mode = { 'n', 'v' }, desc = 'select [p]rompt' },
      { '<leader>an', new_session(), desc = '[n]ew session' },
      { '<leader>as', select_server(), desc = '[s]elect server' },
      { '<leader>at', toggle_panel(), desc = '[t]oggle opencode' },
    },
  },
}
