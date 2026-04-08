--[[
gopls (https://pkg.go.dev/golang.org/x/tools/gopls)
--]]

---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      directoryFilters = { '-.git', '-.idea', '-node_modules', '-.vscode', '-.vscode-test' },
      templateExtensions = { 'gotmpl', 'tmpl' },
      semanticTokens = true,
    },
  },
}
