--[[
eslint (https://github.com/Microsoft/vscode-eslint)
--]]

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.eslint
  settings = {
    format = true,
    run = 'onSave',
    codeActionsOnSave = { enable = true, mode = 'all' },
    workingDirectories = { mode = 'auto' },
  },
}
