--[[
mini.icons (https://github.com/nvim-mini/mini.nvim)
--]]

return {
  {
    'nvim-mini/mini.icons',
    lazy = true,
    opts = {
      extension = {
        ['code-workspace'] = { glyph = '󰨞', hl = 'MiniIconsBlue' },
        kdl = { glyph = '', hl = 'MiniIconsYellow' },
        ['kdl.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
        ['ps1.tmpl'] = { glyph = '󰨊', hl = 'MiniIconsGrey' },
      },
      file = {
        ['.chezmoiroot'] = { glyph = '', hl = 'MiniIconsGrey' },
        ['.chezmoiversion'] = { glyph = '', hl = 'MiniIconsGrey' },
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = {
        curl = { glyph = '', hl = 'MiniIconsRed' },
        dotenv = { glyph = '', hl = 'MiniIconsYellow' },
        http = { glyph = '', hl = 'MiniIconsRed' },
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
