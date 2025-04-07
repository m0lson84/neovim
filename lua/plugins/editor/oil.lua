--[[
oil.nvim (https://github.com/stevearc/oil.nvim)
--]]

--- Open a directory in the file explorer.
---@param dir string | nil The directory to open.
local function explore(dir)
  return function() require('oil').open_float(dir) end
end

return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { 'echasnovski/mini.icons' },
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(_, _) return false end,
        is_always_hidden = function(name, _) return vim.tbl_contains({ '__pycache__', '.DS_Store', 'thumbs.db' }, name) end,
      },
      float = {
        max_width = 0.9,
        max_height = 0.9,
      },
    },
    keys = {
      { '<leader>fl', explore(), desc = '[e]xplore local dir' },
    },
  },
}
