--[[
Tree-sitter utilities.
--]]

---@class util.treesitter
local M = {}

---@type table<string,string>?
M._installed = nil

--- Get all installed parsers
---@param force boolean? whether to force refresh the list
function M.get_installed(force)
  if M._installed and not force then return M._installed end

  M._installed = {}
  for _, lang in ipairs(require('nvim-treesitter').get_installed('parsers')) do
    M._installed[lang] = lang
  end

  return M._installed
end

--- Check if a parser is installed for a given filetype
---@param ft string
function M.have(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and M.get_installed()[lang]
end

return M
