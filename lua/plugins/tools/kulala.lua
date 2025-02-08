--[[
-- kulala.nvim (https://github.com/mistweaverco/kulala.nvim)
--]]

---Execute current request
local execute_request = function() require('kulala').run() end

---Jump to next request
local jump_next = function() require('kulala').jump_next() end

---Jump to previous request
local jump_previous = function() require('kulala').jump_prev() end

---Open a buffer with a temporary file for writing requests
local open_scratchpad = function() require('kulala').scratchpad() end

--- Select environment
local select_env = function() require('kulala').set_selected_env() end

---Toggle response view
local toggle_view = function() require('kulala').toggle_view() end

return {
  {
    'mistweaverco/kulala.nvim',
    opts = {},
    keys = {
      { '<leader>hr', execute_request, ft = 'http', desc = 'execute [r]equest' },
      { '<leader>hn', jump_next, ft = 'http', desc = 'jump to [n]ext request' },
      { '<leader>hp', jump_previous, ft = 'http', desc = 'jump to [p]revious request' },
      { '<leader>hv', toggle_view, ft = 'http', desc = 'toggle response [v]iew' },
      { '<leader>he', select_env, ft = 'http', desc = 'set selected [e]nvironment' },
      { '<leader>hs', open_scratchpad, desc = 'open [s]cratchpad' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'http' },
    },
  },
}
