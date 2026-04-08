--[[
Keyboard mappings
--]]

-- [[ Basic ]]

-- Better up/down
vim.keymap.set({ 'n', 'x' }, 'j', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'up', expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'goto left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'goto lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'goto upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'goto right window', remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = '+ window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = '- window height' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = '+ window width' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = '- window width' })

-- Move lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'move down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'move up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'move down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'move up' })
vim.keymap.set('v', '<A-j>', ':m \'>+1<cr>gv=gv', { desc = 'move down' })
vim.keymap.set('v', '<A-k>', ':m \'<-2<cr>gv=gv', { desc = 'move up' })

-- Buffers
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = '[b]uffer switch' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'switch to other buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = '[D]elete buffer and window' })

-- Clear search with <esc>
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'escape and clear hlsearch' })

-- Clear search, diff update and redraw
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

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = '[K]eywordprg' })

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment above' })

-- Highlights under cursor
vim.keymap.set('n', '<leader>ui', vim.show_pos, { desc = '[i]nspect pos' })
vim.keymap.set('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = '[I]nspect tree' })

-- New file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = '[n]ew file' })

-- Quickfix
vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = '[l]ocation list' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = '[q]uickfix list' })

-- [[ Diagnostics ]]

--- Goto next/previous diagnostic message.
---@param next boolean Whether to go to the next message.
---@param severity? vim.diagnostic.Severity The severity of the diagnostic message.
local function diagnostic_goto(next, severity)
  return function()
    vim.diagnostic.jump({ count = next and 1 or -1, severity = severity, on_jump = vim.diagnostic.open_float })
  end
end

vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'line [d]iagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'next diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'prev diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, vim.diagnostic.severity.ERROR), { desc = 'next error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, vim.diagnostic.severity.ERROR), { desc = 'prev error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, vim.diagnostic.severity.WARN), { desc = 'next warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, vim.diagnostic.severity.WARN), { desc = 'prev warning' })

-- [[ Windows ]]

vim.keymap.set('n', '<leader>w', '<c-w>', { desc = '[w]indows', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'split window right', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = '[d]elete', remap = true })

-- [[ Neovim ]]

vim.keymap.set('n', '<leader>nl', '<cmd>PackStatus<cr>', { desc = '[l]ist plugins' })
vim.keymap.set('n', '<leader>nu', '<cmd>PackUpdate<cr>', { desc = '[u]pdate plugins' })
vim.keymap.set('n', '<leader>nr', '<cmd>PackRestore<cr>', { desc = '[r]estore plugins' })
vim.keymap.set('n', '<leader>nh', '<cmd>PackHealth<cr>', { desc = '[h]ealth check' })

-- [[ Info ]]

vim.keymap.set('n', '<leader>is', function()
  local logfile = vim.fn.tempname()
  vim.system(
    { vim.v.progpath, '--startuptime', logfile, '--headless', '+qa' },
    {},
    vim.schedule_wrap(function()
      local lines = vim.fn.readfile(logfile)
      vim.fn.delete(logfile)

      -- Parse plugin load times
      local plugins = {}
      for _, line in ipairs(lines) do
        local total, self_time, name =
          line:match('^%d+%.%d+%s+(%d+%.%d+)%s+(%d+%.%d+):%s+sourcing%s+.+/%.config/nvim/plugin/(.+)$')
        if total and name then
          name = name:gsub('%.lua$', '')
          table.insert(plugins, { name = name, total = tonumber(total), self = tonumber(self_time) })
        end
      end

      -- Parse total startup time
      local startup = 0
      for i = #lines, 1, -1 do
        startup = lines[i]:match('^(%d+%.%d+).*NVIM STARTED')
        if startup then
          startup = tonumber(startup)
          break
        end
      end

      -- Sort by total time descending
      table.sort(plugins, function(a, b) return a.total > b.total end)

      -- Build output
      local output = { ('Startup: %.1fms (%d plugins)'):format(startup or 0, #plugins), '' }
      table.insert(output, ('  %-30s %8s %8s'):format('Plugin', 'Total', 'Self'))
      table.insert(output, ('  %s %s %s'):format(('-'):rep(30), ('-'):rep(8), ('-'):rep(8)))
      for _, p in ipairs(plugins) do
        table.insert(output, ('  %-30s %7.2fms %7.2fms'):format(p.name, p.total, p.self))
      end

      -- Display in a floating window
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
      vim.bo[buf].modifiable = false
      vim.bo[buf].bufhidden = 'wipe'
      local width = 60
      local height = math.min(#output, 30)
      vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
        title = ' Startup Profile ',
        title_pos = 'center',
      })
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buf = buf, silent = true })
    end)
  )
end, { desc = '[s]tartup info' })
