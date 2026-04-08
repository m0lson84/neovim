--[[
Commands and auto commands
--]]

local autocmd = require('util.autocmd')

-- [[ Auto commands ]]

-- Startup / Core lifecycle --

-- Capture startup time
vim.api.nvim_create_autocmd('UIEnter', {
  group = autocmd.group('startup_time'),
  once = true,
  callback = function()
    local startuptime = vim.g._startuptime
    if startuptime then vim.g._startuptime = (vim.uv.hrtime() - startuptime) / 1e6 end
  end,
})

-- vim.pack hooks: run build steps after plugin install/update
vim.api.nvim_create_autocmd('PackChanged', {
  group = autocmd.group('pack_changed'),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
    if name == 'mason.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('mason.nvim') end
      vim.cmd('MasonUpdate')
    end
    if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
      local dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/blink.cmp'
      vim.system({ 'cargo', 'build', '--release' }, { cwd = dir }):wait()
    end
  end,
})

-- Window / UI behavior --

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = autocmd.group('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = autocmd.group('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- Buffer lifecycle --

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = autocmd.group('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = autocmd.group('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- FileType overrides --

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = autocmd.group('close_with_q'),
  pattern = {
    'checkhealth',
    'dap-float',
    'gitsigns.blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buf = event.buf,
      silent = true,
      desc = 'quit buffer',
    })
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = autocmd.group('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function() vim.wo.conceallevel = 0 end,
})

-- Configure language ruler
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = autocmd.group('language_ruler'),
  callback = function() vim.wo.colorcolumn = vim.bo.textwidth and '+1' or '' end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = autocmd.group('man_unlisted'),
  pattern = { 'man' },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- wrap lines in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = autocmd.group('wrap_spell'),
  pattern = { 'gitcommit', 'markdown', 'plaintext', 'text' },
  callback = function() vim.wo.wrap = true end,
})

-- [[ User commands ]]

-- vim.pack management
vim.api.nvim_create_user_command('PackUpdate', function() vim.pack.update() end, { desc = 'Update all plugins' })
vim.api.nvim_create_user_command(
  'PackStatus',
  function() vim.pack.update(nil, { offline = true }) end,
  { desc = 'Show plugin status' }
)
vim.api.nvim_create_user_command(
  'PackForceUpdate',
  function() vim.pack.update(nil, { force = true }) end,
  { desc = 'Force update all plugins' }
)
vim.api.nvim_create_user_command(
  'PackRestore',
  function() vim.pack.update(nil, { target = 'lockfile' }) end,
  { desc = 'Restore plugins to lockfile state' }
)
vim.api.nvim_create_user_command(
  'PackDelete',
  function(opts) vim.pack.del({ opts.args }) end,
  { nargs = 1, desc = 'Delete a plugin' }
)
vim.api.nvim_create_user_command(
  'PackHealth',
  function() vim.cmd('checkhealth vim.pack') end,
  { desc = 'Plugin health check' }
)
