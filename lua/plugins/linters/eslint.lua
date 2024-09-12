--[[
ESLint (https://eslint.org/)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        eslint = {
          settings = {
            format = true,
            run = 'onSave',
            codeActionsOnSave = { enable = true, mode = 'all' },
            workingDirectories = { mode = 'auto' },
          },
        },
      },
    },
  },
}
