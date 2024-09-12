--[[
persistence.nvim (https://github.com/folke/persistence.nvim)
--]]

return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      { '<leader>qs', function() require('persistence').load() end, desc = 'restore [s]ession' },
      { '<leader>qS', function() require('persistence').select() end, desc = 'select [S]ession' },
      { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'restore [l]ast session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = '[d]on\'t save current session' },
    },
  },
}
