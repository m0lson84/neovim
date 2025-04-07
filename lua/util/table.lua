--[[
Lua table utilities.
--]]

---@class util.table
local M = {}

--- Check if a table can be merged.
--- @param v any: The value to check.
local function can_merge(v) return type(v) == 'table' and (vim.tbl_isempty(v) or not M.is_list(v)) end

--- Create a table with the given keys and value.
---@param keys table: The keys to create the table with.
---@param value any: The value to set for each key.
function M.create(keys, value)
  local table = {}
  for _, key in ipairs(keys) do
    table[key] = value
  end
  return table
end

--- Extend a table of lists by key.
---@param table table The table to extend.
---@param keys table List of keys to extend.
---@param values table The values to extend the table with.
function M.extend_keys(table, keys, values)
  table = table or {}
  for _, key in ipairs(keys) do
    table[key] = vim.list_extend(table[key] or {}, values)
  end
  return table
end

-- Fast implementation to check if a table is a list
---@param t table The table to check.
function M.is_list(t)
  local i = 0
  ---@diagnostic disable-next-line: no-unknown
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then return false end
  end
  return true
end

--- Merges the values similar to vim.tbl_deep_extend with the **force** behavior,
--- but the values can be any type, in which case they override the values on the left.
--- Values will me merged in-place in the first left-most table. If you want the result to be in
--- a new table, then simply pass an empty table as the first argument `vim.merge({}, ...)`
--- Supports clearing values by setting a key to `vim.NIL`
---@generic T
---@param ... T
---@return T
function M.merge(...)
  local ret = select(1, ...)
  if ret == vim.NIL then ret = nil end
  for i = 2, select('#', ...) do
    local value = select(i, ...)
    if can_merge(ret) and can_merge(value) then
      for k, v in pairs(value) do
        ret[k] = M.merge(ret[k], v)
      end
    elseif value == vim.NIL then
      ret = nil
    elseif value ~= nil then
      ret = value
    end
  end
  return ret
end

return M
