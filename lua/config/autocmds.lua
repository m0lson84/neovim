--[[
Auto commands
--]]

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = utils.autocmd.group('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = utils.autocmd.group('highlight_yank'),
  callback = function() vim.highlight.on_yank() end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = utils.autocmd.group('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = utils.autocmd.group('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = utils.autocmd.group('close_with_q'),
  pattern = {
    'checkhealth',
    'dap-float',
    'dbout',
    'gitsigns.blame',
    'grug-far',
    'help',
    'iron',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'oil',
    'PlenaryTestPopup',
    'qf',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'quit buffer',
    })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = utils.autocmd.group('man_unlisted'),
  pattern = { 'man' },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- wrap lines in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = utils.autocmd.group('wrap_spell'),
  pattern = { 'gitcommit', 'markdown', 'plaintext', 'text' },
  callback = function() vim.wo.wrap = true end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = utils.autocmd.group('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function() vim.wo.conceallevel = 0 end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = utils.autocmd.group('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

vim.filetype.add({
  pattern = {
    ['.*'] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= 'bigfile'
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and 'bigfile'
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = utils.autocmd.group('bigfile'),
  pattern = 'bigfile',
  callback = function(ev)
    vim.b.minianimate_disable = true
    vim.schedule(function() vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or '' end)
  end,
})

-- Configure language ruler
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = utils.autocmd.group('language_ruler'),
  callback = function() vim.wo.colorcolumn = vim.bo.textwidth and '+1' or '' end,
})

-- Quit Zellij when quitting Neovim
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  group = utils.autocmd.group('quit_zellij'),
  pattern = '*',
  callback = function() os.execute('zellij k "$ZELLIJ_SESSION_NAME"') end,
})
