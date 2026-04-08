--[[
eslint (https://github.com/Microsoft/vscode-eslint)
--]]

---@type vim.lsp.Config
return {
  settings = {
    format = true,
    run = 'onSave',
    codeActionsOnSave = { enable = true, mode = 'all' },
    workingDirectories = { mode = 'auto' },
  },
}
