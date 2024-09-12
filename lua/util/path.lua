---@class util.path
local M = {}

--- Join a list of paths.
---@param ... string | string[] The paths to join.
---@return string path The joined path.
function M.join(...) return table.concat(vim.iter({ ... }):flatten():totable(), '/') end

--- Normalize the input path
--- @param path string  The input path.
---@return string The normalized path.
function M.norm(path)
  if path:sub(1, 1) == '~' then
    local home = vim.uv.os_homedir()
    if home and (home:sub(-1) == '\\' or home:sub(-1) == '/') then home = home:sub(1, -2) end
    path = home .. path:sub(2)
  end
  path = path:gsub('\\', '/'):gsub('/+', '/')
  return path:sub(-1) == '/' and path:sub(1, -2) or path
end

return M
