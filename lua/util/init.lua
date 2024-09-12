--[[
  Global utility functions.
  @module Utilities
  @alias utils
]]

local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require('util.' .. k)
    return t[k]
  end,
})

--- Get configured logger.
---@return PlenaryLogger logger Local logging instance.
function M.get_logger()
  return require('plenary.log').new({
    plugin = 'Local',
    level = 'debug',
    use_console = 'async',
    outfile = vim.fn.stdpath('state') .. 'local.log',
    fmt_msg = function(_, mode, path, line, msg)
      return ('%-6s%s %s: %s\n'):format(mode:upper(), os.date(), vim.fn.fnamemodify(path, ':.') .. ':' .. line, msg)
    end,
  })
end

return M
