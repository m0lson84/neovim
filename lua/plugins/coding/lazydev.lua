--[[
lazydev.nvim (https://github.com/folke/lazydev.nvim)
--]]

-- TODO: Move to language specific configurations

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
    lazy = true,
  },
}
