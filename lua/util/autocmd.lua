--[[
Autocmd utilities
--]]

---@class util.autocmd
local M = {}

--- Create a namespaced augroup with `clear = true`.
---@param name string The augroup suffix (prefixed with `local_`).
---@return integer augroup_id
function M.group(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end

return M
