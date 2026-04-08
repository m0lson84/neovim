--[[
Mason package utilities
--]]

---@class util.pkg
local M = {}

--- Get a path to a package in the Mason registry.
---@param pkg string The package name.
---@param path? string The path within the package.
---@param opts? { warn?: boolean } Options.
function M.get_path(pkg, path, opts)
  pcall(require, 'mason')
  local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. '/' .. path
  if opts.warn and not vim.uv.fs_stat(ret) then
    vim.notify(
      ('Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.'):format(pkg, path),
      vim.log.levels.WARN
    )
  end
  return ret
end

return M
