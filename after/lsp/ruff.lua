--[[
ruff (https://github.com/astral-sh/ruff)
--]]

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.ruff
  settings = {
    lint = {
      select = { 'ALL' },
    },
  },
}
