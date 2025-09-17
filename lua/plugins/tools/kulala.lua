--[[
-- kulala.nvim (https://github.com/mistweaverco/kulala.nvim)
--]]

---Execute current request
local function execute_request()
  return function() require('kulala').run() end
end

---Jump to next request
local function jump_next()
  return function() require('kulala').jump_next() end
end

---Jump to previous request
local function jump_previous()
  return function() require('kulala').jump_prev() end
end

---Open a buffer with a temporary file for writing requests
local function open_scratchpad()
  return function() require('kulala').scratchpad() end
end

--- Select environment
local function select_env()
  return function() require('kulala').set_selected_env() end
end

---Toggle response view
local function toggle_view()
  return function() require('kulala').toggle_view() end
end

return {
  {
    'mistweaverco/kulala.nvim',
    opts = {},
    keys = {
      { '<leader>hr', execute_request(), ft = 'http', desc = 'execute [r]equest' },
      { '<leader>hn', jump_next(), ft = 'http', desc = 'jump to [n]ext request' },
      { '<leader>hp', jump_previous(), ft = 'http', desc = 'jump to [p]revious request' },
      { '<leader>hv', toggle_view(), ft = 'http', desc = 'toggle response [v]iew' },
      { '<leader>he', select_env(), ft = 'http', desc = 'set selected [e]nvironment' },
      { '<leader>hs', open_scratchpad(), desc = 'open [s]cratchpad' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'http' },
    },
  },
}
