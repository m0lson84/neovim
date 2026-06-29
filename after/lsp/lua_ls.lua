--[[
lua_ls (https://github.com/LuaLS/lua-language-server)
--]]

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
      hint = { enable = true },
    },
  },
}
