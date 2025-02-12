--[[

                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

--]]

-- Set globals
_G.config = require('config')
_G.utils = require('util')

-- Load configuration
require('config.options')
require('config.lazy')
require('config.keymaps')

-- [[ Configure and install plugins ]]
require('lazy').setup({
  defaults = {
    lazy = false,
    version = false,
  },
  spec = {
    { import = 'plugins.core' },
    { import = 'plugins.coding' },
    { import = 'plugins.editor' },
    { import = 'plugins.formatters' },
    { import = 'plugins.langs' },
    { import = 'plugins.linters' },
    { import = 'plugins.tools' },
    { import = 'plugins.ui' },
  },
  rocks = { enabled = false },
  install = { colorscheme = { 'tokyonight' } },
  checker = { enabled = true },
  ui = { title = 'lazy.nvim', border = 'rounded' },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

require('config.autocmds')
