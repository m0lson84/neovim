--[[
which-key.nvim (https://github.com/folke/which-key.nvim)
--]]

return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec' },
    opts = {
      icons = {
        mappings = true,
        keys = {},
      },
      spec = {
        mode = { 'n', 'v' },
        { 'gx', desc = 'open with system app' },
        {
          '<leader>b',
          group = '[b]uffer',
          icon = { icon = '󰓩', color = 'cyan' },
          expand = function() return require('which-key.extras').expand.buf() end,
        },
        { '<leader>a', group = '[a]i', icon = { icon = '󰚩', color = 'blue' } },
        { '<leader>c', group = '[c]ode', icon = { icon = '', color = 'green' } },
        { '<leader>d', group = '[d]ebug', icon = { icon = '', color = 'red' } },
        { '<leader>f', group = '[f]ile', icon = { icon = '', color = 'gray' } },
        { '<leader>g', group = '[g]it', icon = { icon = '', color = 'orange' } },
        { '<leader>gh', group = '[g]it [h]unks', icon = { icon = '', color = 'orange' } },
        { '<leader>h', group = '[h]ttp', icon = { icon = '', color = 'red' } },
        { '<leader>i', group = '[i]nfo', icon = { icon = '', color = 'azure' } },
        { '<leader>j', group = '[j]upyter', icon = { icon = '', color = 'orange' } },
        { '<leader>n', group = '[n]eovim', icon = { icon = '', color = 'green' } },
        { '<leader>q', group = '[q]uit', icon = { icon = '󰈆', color = 'red' } },
        { '<leader>s', group = '[s]earch', icon = { icon = '', color = 'gray' } },
        { '<leader>t', group = '[t]est', icon = { icon = '󰙨', color = 'green' } },
        { '<leader>u', group = '[u]i', icon = { icon = '󰇄', color = 'blue' } },
        { '<leader>x', group = 'quickfi[x]', icon = { icon = '󱖫 ', color = 'green' } },
        {
          '<leader>w',
          proxy = '<c-w>',
          group = '[w]indows',
          icon = { icon = '', color = 'azure' },
          expand = function() return require('which-key.extras').expand.win() end,
        },
        { '<leader>x', group = 'quickfi[x]' },
      },
    },
    keys = {
      {
        '<leader>?',
        function() require('which-key').show({ global = false }) end,
        desc = 'buffer keymaps (which-key)',
      },
    },
  },
}
