---@class util.terminal
---@overload fun(cmd: string|string[], opts: TerminalOpts): LazyFloat
local M = setmetatable({}, {
  __call = function(m, ...) return m.open(...) end,
})

---@class TerminalOpts: LazyCmdOptions
---@field interactive? boolean
---@field esc_esc? boolean
---@field ctrl_hjkl? boolean

---@type table<string,LazyFloat>
local terminals = {}

-- Open lazygit in a floating terminal
---@param opts? TerminalOpts
function M.lazygit(opts)
  opts = vim.tbl_deep_extend('force', {}, {
    border = 'none',
    esc_esc = false,
    ctrl_hjkl = false,
  }, opts or {})

  local cmd = { 'lazygit' }
  vim.list_extend(cmd, opts.args or {})

  return M.open(cmd, opts)
end

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? TerminalOpts
function M.open(cmd, opts)
  opts = vim.tbl_deep_extend('force', {
    ft = 'lazyterm',
    size = { width = 0.9, height = 0.9 },
    backdrop = not cmd and 100 or nil,
  }, opts or {}, { persistent = true }) --[[@as TerminalOpts]]

  local termkey = vim.inspect({
    cmd = cmd or 'shell',
    cwd = opts.cwd,
    env = opts.env,
    count = vim.v.count1,
  })

  if terminals[termkey] and terminals[termkey]:buf_valid() then
    terminals[termkey]:toggle()
  else
    terminals[termkey] = require('lazy.util').float_term(cmd, opts)
    local buf = terminals[termkey].buf
    vim.b[buf].lazyterm_cmd = cmd
    if opts.esc_esc == false then vim.keymap.set('t', '<esc>', '<esc>', { buffer = buf, nowait = true }) end
    if opts.ctrl_hjkl == false then
      vim.keymap.set('t', '<c-h>', '<c-h>', { buffer = buf, nowait = true })
      vim.keymap.set('t', '<c-j>', '<c-j>', { buffer = buf, nowait = true })
      vim.keymap.set('t', '<c-k>', '<c-k>', { buffer = buf, nowait = true })
      vim.keymap.set('t', '<c-l>', '<c-l>', { buffer = buf, nowait = true })
    end

    vim.keymap.set('n', 'gf', function()
      local f = vim.fn.findfile(vim.fn.expand('<cfile>'))
      if f ~= '' then
        vim.cmd('close')
        vim.cmd('e ' .. f)
      end
    end, { buffer = buf })

    vim.api.nvim_create_autocmd('BufEnter', {
      buffer = buf,
      callback = function() vim.cmd.startinsert() end,
    })

    vim.cmd('noh')
  end

  return terminals[termkey]
end

return M