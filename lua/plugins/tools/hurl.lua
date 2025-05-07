--[[
-- hurl.nvim (https://github.com/jellydn/hurl.nvim)
--]]

return {
  {
    'jellydn/hurl.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'hurl',
    keys = {
      { '<leader>ha', '<cmd>HurlRunner<cr>', ft = 'hurl', desc = 'execute [a]ll requests' },
      { '<leader>hr', '<cmd>HurlRunnerAt<cr>', ft = 'hurl', desc = 'execute selected [r]equest' },
      { '<leader>hv', '<cmd>HurlVerbose<cr>', ft = 'hurl', desc = 'execute in [v]erbose mode' },
      { '<leader>hl', '<cmd>HurlShowLastResposne<cr>', ft = 'hurl', desc = 'show [l]ast response' },
      { '<leader>ht', '<cmd>HurlToggleMode<cr>', ft = 'hurl', desc = '[t]oggle display mode' },
      { '<leader>hm', '<cmd>HurlManageVariable<cr>', ft = 'hurl', desc = '[m]anage environment' },
    },
    opts = {
      debug = true,
      mode = 'split',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'hurl' },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      formatters = {
        hurlfmt = {},
      },
      formatters_by_ft = {
        hurl = { 'hurlfmt' },
      },
    },
  },
}
