---@class util.ui
local M = {}

---@param buf number?
function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then return end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr('#')
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, 'bprevious')
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then return end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then pcall(vim.cmd, 'bdelete! ' .. buf) end
end

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
