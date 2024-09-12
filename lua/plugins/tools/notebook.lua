--[[
NotebookNavigator.nvim (https://github.com/GCBallesteros/NotebookNavigator.nvim)
--]]

return {
  {
    'GCBallesteros/NotebookNavigator.nvim',
    dependencies = { 'Vigemus/iron.nvim' },
    event = 'VeryLazy',
    opts = {
      repl_provider = 'molten',
      syntax_highlight = true,
    },
    keys = function()
      local notebook = require('notebook-navigator')
      return {
        { '<leader>jc', notebook.run_cell, desc = 'run [c]ell' },
        { '<leader>jm', notebook.run_and_move, desc = 'run and [m]ove' },
        { '<leader>ja', notebook.run_all_cells, desc = 'run [a]ll cells' },
        { '<leader>jb', notebook.run_all_cells, desc = 'run [b]elow' },
      }
    end,
    config = function(_, opts)
      local notebook = require('notebook-navigator')
      notebook.setup(opts)
    end,
  },
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
    opts = function(_, opts)
      opts.custom_textobjects = vim.list_extend(opts.custom_textobjects, {
        { h = require('notebook-navigator').miniai_spec },
      })
      return opts
    end,
  },
}
