--[[
Code formatter utilities.
--]]

---@class util.format
local M = {}

--- Get the list of available formatters for the given buffer.
---@param bufnr integer The buffer to format.
---@param ... string[] The list of formatters to try.
---@return string[] formatters The configured formatter.
function M.available(bufnr, ...)
  local conform = require('conform')
  local ret = {}
  for i = 1, select('#', ...) do
    local fmt = select(i, ...)
    local info = conform.get_formatter_info(fmt, bufnr)
    if info.available then table.insert(ret, fmt) end
  end
  return ret
end

--- Select the first available formatter for the given buffer.
---@param bufnr integer The buffer to format.
---@param ... string[] The list of formatters to try.
---@return string formatter The selected formatter.
function M.first(bufnr, ...)
  local conform = require('conform')
  for i = 1, select('#', ...) do
    local fmt = select(i, ...)
    local info = conform.get_formatter_info(fmt, bufnr)
    if info.available and info.cwd ~= nil then return fmt end
  end
  return select(1, ...)
end

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
