--[[
-- Plugins for interfacing with Jupyter Notebooks
--]]

return {
  {
    'GCBallesteros/jupytext.nvim',
    event = 'VeryLazy',
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {
          ensure_installed = { 'jupytext' },
        },
      },
    },
    opts = {
      style = 'markdown',
      output_extension = 'md',
      force_ft = 'markdown',
    },
  },
}
