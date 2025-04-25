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
    ---@param opts snacks.Config
    ---@return snacks.Config
    opts = function(_, opts)
      opts.picker = { sources = {} }
      for _, source in ipairs({ 'files', 'grep' }) do
        opts.picker.sources[source] = {
          hidden = true,
          exclude = {
            '__pycache__',
            '.DS_Store',
            'thumbs.db',
          },
        }
      end
      return opts
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
