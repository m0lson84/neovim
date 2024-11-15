---@class util.ui
local M = {}

---@return {fg?:string}?
function M.fg(name)
  local color = M.color(name)
  return color and { fg = color } or nil
end

---@return {bg?:string}?
function M.bg(name)
  local color = M.color(name, true)
  return color and { bg = color } or nil
end

---@param name string
---@param bg? boolean
---@return string?
function M.color(name, bg)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local color = bg and (hl.bg or hl.background) or (hl.fg or hl.foreground)
  return color and string.format('#%06x', color) or nil
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
  sign = sign or {}
  len = len or 2
  local text = vim.fn.strcharpart(sign.text or '', 0, len) ---@type string
  text = text .. string.rep(' ', len - vim.fn.strchars(text))
  return sign.texthl and ('%#' .. sign.texthl .. '#' .. text .. '%*') or text
end

return M
