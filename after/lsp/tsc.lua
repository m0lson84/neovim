--[[
tsc (https://github.com/microsoft/typescript)
--]]

---@type vim.lsp.Config
return {
  settings = {
    ['js/ts'] = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = false },
        parameterNames = { enabled = 'literals', suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}
