--[[
quarto-nvim (https://github.com/quarto-dev/quarto-nvim)
--]]

return {
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'quarto' },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = 'all',
        languages = { 'python' },
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten',
        never_run = { 'yaml' },
      },
    },
    keys = function()
      return {
        { '<leader>ja', '<cmd>QuartoSendAbove<cr>', desc = 'run [a]bove cells' },
        { '<leader>jA', '<cmd>QuartoSendAll<cr>', desc = 'run [a]ll cells' },
        { '<leader>jb', '<cmd>QuartoSendBelow<cr>', desc = 'run [b]elow cells' },
        { '<leader>jc', '<cmd>QuartoSend<cr>', desc = 'run [c]ell' },
        { '<leader>jp', '<cmd>QuartoPreview<cr>', desc = '[p]review notebook' },
        { '<leader>jP', '<cmd>QuartoPreview<cr>', desc = 'close [p]review' },
        { '<leader>ju', '<cmd>QuartoPreview<cr>', desc = '[u]pdate preview' },
      }
    end,
  },
}
