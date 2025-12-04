--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

--- Open the explorer at a given directory
---@param dir string | nil The directory to open.
local explore = function(dir)
  return function() Snacks.explorer({ cwd = dir }) end
end

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
    opts = function(_, opts)
      local exclude = { '__pycache__', '.DS_Store', 'thumbs.db' }
      opts.explorer = {}
      opts.picker = {
        sources = {
          explorer = { hidden = true, ignored = true, exclude = exclude },
          files = { hidden = true, exclude = exclude },
          grep = { hidden = true, exclude = exclude },
        },
      }
      return opts
    end,
    keys = {
      { '<leader>e', '<leader>fe', desc = '[e]xplorer cwd', remap = true },
      { '<leader>fe', explore(vim.uv.cwd()), desc = '[e]xplorer cwd' },
      { '<leader>fE', explore(utils.root()), desc = '[e]xplorer root' },
      { '<leader><leader>', pick('files'), desc = 'search files' },
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
