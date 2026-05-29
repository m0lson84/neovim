--[[
snacks.nvim (https://github.com/folke/snacks.nvim)
--]]

vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

local exclude = { '__pycache__', '.DS_Store', 'thumbs.db' }

--- Open a file explorer in the given directory..
---@param dir? string The directory to open. Defaults to the cwd.
local function explore(dir)
  return function() Snacks.explorer({ cwd = dir }) end
end

--- Open lazygit in a floating terminal.
local function lazygit()
  if vim.env.ZELLIJ == nil then
    Snacks.lazygit({ cwd = vim.fs.root(0, '.git') or vim.uv.cwd() })
    return
  end
  vim.fn.system({
    'zellij',
    'run',
    '--floating',
    '--close-on-exit',
    '--borderless',
    'true',
    '--name',
    'lazygit',
    '--width',
    '90%',
    '--height',
    '90%',
    '--',
    'lazygit',
  })
end

--- Open a picker of the given type.
---@param type string
---@param opts? table
local function pick(type, opts)
  return function() Snacks.picker[type](opts) end
end

--- Open a terminal with the given command(s).
---@param cmd? string | string[]
local function terminal(cmd)
  return function()
    Snacks.terminal(cmd, {
      cwd = vim.fs.root(0, '.git') or vim.uv.cwd(),
    })
  end
end

require('snacks').setup({
  bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },
  explorer = { trash = false },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = {
    ui_select = true,
    sources = {
      explorer = { hidden = true, ignored = true, exclude = exclude },
      files = { hidden = true, exclude = exclude },
      grep = { hidden = true, exclude = exclude },
    },
  },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  terminal = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = { wo = { wrap = true } },
  },
})

vim.keymap.set('n', '<c-/>', terminal(), { desc = 'terminal (root)' })
vim.keymap.set('n', '<c-_>', terminal(), { desc = 'which_key_ignore' })
vim.keymap.set('n', '<leader><leader>', pick('files'), { desc = 'search files' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[d]elete buffer' })
vim.keymap.set('n', '<leader>e', '<leader>fe', { desc = '[e]xplorer cwd', remap = true })
vim.keymap.set('n', '<leader>fe', explore(vim.uv.cwd()), { desc = '[e]xplorer cwd' })
vim.keymap.set('n', '<leader>fE', explore(vim.fs.root(0, '.git') or vim.uv.cwd()), { desc = '[e]xplorer root' })
vim.keymap.set('n', '<leader>ft', terminal(), { desc = '[T]erminal (root)' })
vim.keymap.set('n', '<leader>fT', function() Snacks.terminal() end, { desc = '[T]erminal (cwd)' })
vim.keymap.set('n', '<leader>gg', lazygit, { desc = 'lazy[g]it' })
vim.keymap.set('n', '<leader>sb', pick('buffers'), { desc = '[b]uffers' })
vim.keymap.set('n', '<leader>sd', pick('diagnostics'), { desc = '[d]iagnostics' })
vim.keymap.set('n', '<leader>sf', pick('files'), { desc = '[f]iles' })
vim.keymap.set('n', '<leader>sg', pick('grep'), { desc = 'live [g]rep' })
vim.keymap.set('n', '<leader>sh', pick('help'), { desc = '[h]elp' })
vim.keymap.set('n', '<leader>sk', pick('keymaps'), { desc = '[k]eymaps' })
vim.keymap.set('n', '<leader>sw', pick('grep_word'), { desc = 'current [w]ord' })
