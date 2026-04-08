--[[
lualine.nvim (https://github.com/nvim-lualine/lualine.nvim)
--]]

local icons = require('config.icons')

vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local function fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local color = hl.fg or hl.foreground
  return color and { fg = string.format('#%06x', color) } or nil
end

vim.g.lualine_laststatus = vim.o.laststatus
if vim.fn.argc(-1) > 0 then
  vim.o.statusline = ' '
else
  vim.o.laststatus = 0
end

vim.o.laststatus = vim.g.lualine_laststatus

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'diagnostics',
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      {
        'filetype',
        icon_only = true,
        separator = '',
        padding = { left = 1, right = 0 },
      },
    },
    lualine_x = {
      {
        function() return require('noice').api.status.command.get() end,
        cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
        color = function() return fg('Statement') end,
      },
      {
        function() return require('noice').api.status.mode.get() end,
        cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
        color = function() return fg('Constant') end,
      },
      {
        function()
          local reg = vim.fn.reg_recording()
          return reg ~= '' and ('recording @' .. reg) or ''
        end,
        cond = function() return vim.fn.reg_recording() ~= '' end,
        color = function() return fg('Constant') end,
      },
      {
        function() return '  ' .. require('dap').status() end,
        cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
        color = function() return fg('Debug') end,
      },
      {
        'diff',
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    },
    lualine_y = {
      { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
      { 'location', padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function() return ' ' .. os.date('%R') end,
    },
  },
  extensions = { 'neo-tree' },
})
