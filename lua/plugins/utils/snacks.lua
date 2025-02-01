--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

---Open a snacks picker
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
    opts = function()
      local opts = {}

      local defaults = { 'bigfile', 'indent', 'notifier', 'scroll', 'statuscolumn', 'words' }
      for _, d in ipairs(defaults) do
        opts[d] = { enabled = true }
      end

      return vim.tbl_deep_extend('force', opts, {
        picker = {
          sources = {
            files = { hidden = true },
            grep = { hidden = true },
          },
        },
        styles = {
          notification = {
            wo = { wrap = true },
          },
        },
      })
    end,
    keys = {
      { '<leader><leader>', pick('files'), desc = '[ ] search files' },
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
