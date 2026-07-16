--[[
zls (https://github.com/zigtools/zls)
--]]

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.zls
  settings = {
    zls = {
      single_file_support = true,
    },
  },
}
