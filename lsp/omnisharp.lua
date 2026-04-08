--[[
omnisharp (https://github.com/OmniSharp/omnisharp-roslyn)
--]]

---@type vim.lsp.Config
return {
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
}
