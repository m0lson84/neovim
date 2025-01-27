--[[
Directory utilities.
--]]

---@class util.dir
local M = {}

--- Checks whether a directory exists at the given path.
---@param path string: The path to check.
function M.exists(path)
  local full_path = vim.fn.resolve(path)
  return vim.fn.isdirectory(full_path) ~= 0
end

--- Get the path to the input directory (if exists).
---@param name string The name of the directory to find.
---@param start_dir string|nil The path in which to start the search. Defaults to the current working directory.
---@return string|nil
function M.find(name, start_dir)
  local root = vim.fn.resolve(start_dir) or vim.fn.getcwd()
  local found = vim.fs.find(name, { type = 'directory', path = root })
  if not found or #found == 0 then return nil end
  return found[1]
end

--- Get the name of the directory for a given path.
---@param path string: The path to get the directory name for.
function M.name(path)
  if not path or #path == 0 then return end
  local result = path:gsub('/$', ''):gsub('/([^/]+)$', '')
  if #result ~= 0 then return result end
  return '/'
end

return M
