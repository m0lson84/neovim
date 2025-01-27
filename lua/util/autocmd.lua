--[[
Auto-commands utilities.
--]]

---@class util.autocmd
M = {}

--- Create a new autocmd group
---@param name string The name of the group to create
function M.group(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end

return M
