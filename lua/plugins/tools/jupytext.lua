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
      custom_language_formatting = {
        python = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
        r = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
      },
    },
  },
}
