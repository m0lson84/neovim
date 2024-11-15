--[[
Keyboard mappings
--]]

-- [[ basic ]]

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'up', expr = true, silent = true })

-- move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'goto left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'goto lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'goto upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'goto right window', remap = true })

-- resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = '+ window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = '- window height' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = '+ window width' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = '- window width' })

-- move lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'move down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'move up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'move down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'move up' })
vim.keymap.set('v', '<A-j>', ':m \'>+1<cr>gv=gv', { desc = 'move down' })
vim.keymap.set('v', '<A-k>', ':m \'<-2<cr>gv=gv', { desc = 'move up' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'prev buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = '[b]uffer switch' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'switch to other buffer' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[d]elete buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = '[D]elete buffer and window' })

-- clear search with <esc>
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'escape and clear hlsearch' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- clear search, diff update and redraw
vim.keymap.set(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', '\'Nn\'[v:searchforward].\'zv\'', { expr = true, desc = 'next search result' })
vim.keymap.set('x', 'n', '\'Nn\'[v:searchforward]', { expr = true, desc = 'next search result' })
vim.keymap.set('o', 'n', '\'Nn\'[v:searchforward]', { expr = true, desc = 'next search result' })
vim.keymap.set('n', 'N', '\'nN\'[v:searchforward].\'zv\'', { expr = true, desc = 'prev search result' })
vim.keymap.set('x', 'N', '\'nN\'[v:searchforward]', { expr = true, desc = 'prev search result' })
vim.keymap.set('o', 'N', '\'nN\'[v:searchforward]', { expr = true, desc = 'prev search result' })

-- add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

--keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = '[K]eywordprg' })

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment above' })

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[q]uit all' })

-- highlights under cursor
vim.keymap.set('n', '<leader>ui', vim.show_pos, { desc = '[i]nspect pos' })
vim.keymap.set('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = '[I]nspect tree' })

-- lazy
vim.keymap.set('n', '<leader>nl', '<cmd>Lazy<cr>', { desc = '[l]azy' })

-- new file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = '[n]ew file' })

-- quickfix
vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = '[l]ocation list' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = '[q]uickfix list' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'next quickfix' })

-- [[ diagnostics ]]

--- goto next/previous diagnostic message.
---@param next boolean whether to go to the next message.
---@param severity ?vim.diagnostic.Severity the severity of the diagnostic message.
local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({
      count = next and 1 or -1,
      float = true,
      severity = severity,
    })
  end
end

vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'line [d]iagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'next diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'prev diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'next error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'prev error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'next warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'prev warning' })

-- [[ lazygit ]]

--- open lazygit in a terminal window.
---@param cwd ?string the current working directory.
local lazygit = function(cwd) Snacks.lazygit({ cwd = cwd }) end

vim.keymap.set('n', '<leader>gg', function() lazygit(utils.root()) end, { desc = 'lazy[g]it (root)' })
vim.keymap.set('n', '<leader>gG', function() lazygit() end, { desc = 'lazy[G]it (cwd)' })

-- [[ terminal ]]

local lazyterm = function() utils.terminal(nil, { cwd = utils.root() }) end

--- Switch to terminal tab if running in Zellij else open lazyterm.
local terminal = function()
  if vim.env.ZELLIJ ~= nil then
    vim.fn.system({ 'zellij', 'action', 'go-to-tab-name', 'terminal', '--create' })
    vim.fn.system({ 'zellij', 'action', 'switch-mode', 'normal' })
    return
  end
  utils.terminal(nil, { cwd = utils.root() })
end

vim.keymap.set('n', '<leader>ft', lazyterm, { desc = '[t]erminal (root)' })
vim.keymap.set('n', '<leader>fT', function() utils.terminal() end, { desc = '[T]erminal (cwd)' })
vim.keymap.set('n', '<c-/>', terminal, { desc = 'terminal (root)' })
vim.keymap.set('n', '<c-_>', terminal, { desc = 'which_key_ignore' })

-- terminal mappings
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'enter normal mode' })
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'goto left window' })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'goto lower window' })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'goto upper window' })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'goto right window' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'hide terminal' })
vim.keymap.set('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- [[ windows ]]

vim.keymap.set('n', '<leader>w', '<c-w>', { desc = '[w]indows', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'split window right', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = '[d]elete', remap = true })
