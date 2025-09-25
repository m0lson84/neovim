--[[
Ruff (https://docs.astral.sh/ruff/)
--]]

--- Organize all imports
local function organize_imports()
  return function()
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' }, diagnostics = {} },
      apply = true,
    })
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          settings = {
            lint = {
              select = { 'ALL' },
            },
          },
          keys = {
            { '<leader>co', organize_imports(), desc = '[o]rganize imports' },
          },
        },
      },
      setup = {
        ruff = function()
          utils.lsp.on_attach(function(client, _) client.server_capabilities.hoverProvider = false end, 'ruff')
        end,
      },
    },
  },
}
