--[[
Colorscheme configuration
--]]

vim.pack.add({ 'https://github.com/folke/tokyonight.nvim' }, { load = true })

require('tokyonight').setup({
  style = 'night',
  plugins = { markdown = true },
  on_colors = function(colors)
    local util = require('tokyonight.util')
    colors.bg = colors.bg_dark
    colors.border = util.blend(colors.dark3, 0.9, colors.fg_dark)
    colors.border_highlight = util.blend(colors.blue1, 0.8, colors.bg)
    colors.unused = util.blend(colors.terminal_black, 0.6, colors.fg_dark)
  end,
  on_highlights = function(highlights, colors)
    highlights.ColorColumn = { bg = colors.fg }
    highlights.DiagnosticUnnecessary = { fg = colors.unused, bg = colors.none }
    highlights.DiagnosticVirtualTextError = { fg = colors.error, bg = colors.none }
    highlights.DiagnosticVirtualTextWarn = { fg = colors.warning, bg = colors.none }
    highlights.DiagnosticVirtualTextInfo = { fg = colors.info, bg = colors.none }
    highlights.DiagnosticVirtualTextHint = { fg = colors.hint, bg = colors.none }
    highlights.LspInlayHint = { fg = colors.dark3, bg = colors.none }
    highlights.BlinkCmpDocBorder = { fg = colors.border_highlight, bg = colors.bg_float }
    highlights.BlinkCmpMenuBorder = { fg = colors.border_highlight, bg = colors.bg_float }
  end,
})

vim.cmd.colorscheme('tokyonight')
