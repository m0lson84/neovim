--[[
oil.nvim (https://github.com/stevearc/oil.nvim)
--]]

return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {
      columns = { 'icon' },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          local hidden = { '__pycache__', '.DS_Store', 'thumbs.db' }
          return vim.tbl_contains(hidden, name)
        end,
      },
      float = {
        border = vim.g.window_border,
        preview_split = 'right',
      },
      preview = { border = vim.g.window_border },
      keymaps_help = { border = vim.g.window_border },
    },
    keys = {
      { '<leader>fo', function() require('oil').open_float() end, desc = '[o]il cwd' },
    },
  },
}
