--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

---Open a picker
---@param type string The type of picker to open.
---@param opts table | nil The options to pass to the picker.
local function pick(type, opts)
  return function() Snacks.picker[type](opts) end
end

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
        },
      },
    },
    keys = {
      { '<leader><leader>', pick('files'), desc = '[ ] search files' },
      { '<leader>e', '<leader>fe', desc = '[e]xplorer cwd', remap = true },
      { '<leader>fe', pick('explorer', { cwd = vim.uv.cwd() }), desc = '[e]xplorer cwd' },
      { '<leader>fE', pick('explorer', { cwd = utils.root() }), desc = '[e]xplorer root' },
      { '<leader>sb', pick('buffers'), desc = '[b]uffers' },
      { '<leader>sd', pick('diagnostics'), desc = '[d]iagnostics' },
      { '<leader>sf', pick('files'), desc = '[f]iles' },
      { '<leader>sg', pick('grep'), desc = 'live [g]rep' },
      { '<leader>sh', pick('help'), desc = '[h]elp' },
      { '<leader>sk', pick('keymaps'), desc = '[k]eymaps' },
      { '<leader>sw', pick('grep_word'), desc = 'current [w]ord' },
    },
  },
}
