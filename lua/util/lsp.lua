--[[
LSP utilities
--]]

---@class util.lsp
local M = {}

--- Get all configured LSP server names.
--- Scans `lsp/*.lua` files in the user config directory (`stdpath('config')`)
--- and returns server names derived from the filenames (without the `.lua` extension).
---@return string[] servers List of LSP server names.
function M.servers()
  local servers = {}
  for _, path in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. '/lsp/*.lua', false, true)) do
    table.insert(servers, vim.fn.fnamemodify(path, ':t:r'))
  end
  return servers
end

return M
