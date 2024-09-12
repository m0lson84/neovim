--[[
molten-nvim (https://github.com/benlubas/molten-nvim)
--]]

return {
  {
    'benlubas/molten-nvim',
    event = 'VeryLazy',
    build = ':UpdateRemotePlugins',
    init = function() end,
    keys = {
      { '<leader>jk', '', desc = 'start [k]ernel' },
    },
  },
}
