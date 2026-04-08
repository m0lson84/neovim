--[[
Code formatter utilities
--]]

---@class util.format
local M = {}

--- Get the first configured formatter for the current buffer.
---@param bufnr integer The buffer to format.
---@param ... string[] The list of formatters to try.
---@return string | nil formatter The selected formatter.
function M.get(bufnr, ...)
  for i = 1, select('#', ...) do
    local fmt = select(i, ...)
    local info = require('conform').get_formatter_info(fmt, bufnr)
    if info.available and info.cwd ~= nil then return fmt end
  end
  return select(1, ...)
end

return M
