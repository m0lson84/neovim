--[[
Ruff (https://beta.ruff.rs/docs/)
--]]

--- Organize all imports
local organize_imports = function()
  vim.lsp.buf.code_action({
    context = { only = { 'source.organizeImports' }, diagnostics = {} },
    apply = true,
  })
end

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'ruff' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      servers = {
        ruff = {
          settings = {
            lint = {
              select = { 'ALL' },
            },
          },
          keys = {
            { '<leader>co', organize_imports, desc = '[o]rganize imports' },
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
