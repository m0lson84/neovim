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

-- Record startup time
vim.g._startuptime = vim.uv.hrtime()

-- Enable fast module loading
vim.loader.enable()

-- Load configuration
require('config.options')
require('config.commands')
require('config.keymaps')
require('config.colorscheme')
