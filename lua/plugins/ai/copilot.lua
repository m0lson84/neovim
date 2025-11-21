--[[
copilot.lua (https://github.com/zbirenbaum/copilot.lua)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {},
      },
      setup = {
        copilot = function()
          vim.lsp.config('copilot', {
            handlers = {
              didChangeStatus = function(err, res, _)
                if err then return end
                if res.status == 'Error' then
                  vim.notify('Please use `:LspCopilotSignIn` to sign into Copilot', vim.log.levels.ERROR)
                end
              end,
            },
          })
        end,
      },
    },
  },

  {
    'saghen/blink.cmp',
    dependencies = { 'fang2hou/blink-copilot' },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            async = true,
          },
        },
      },
    },
  },
}
