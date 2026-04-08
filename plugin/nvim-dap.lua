--[[
nvim-dap (https://github.com/mfussenegger/nvim-dap)
--]]

local initialized = false
local function ensure_init()
  if initialized then return end
  initialized = true

  vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/jay-babu/mason-nvim-dap.nvim',
    'https://github.com/leoluz/nvim-dap-go',
    'https://github.com/mfussenegger/nvim-dap-python',
  })

  local icons = require('config.icons')
  local pkg = require('util.pkg')
  local dap = require('dap')
  local dapui = require('dapui')

  require('nvim-dap-virtual-text').setup({})
  require('mason-nvim-dap').setup({ automatic_installation = true, handlers = {}, ensure_installed = {} })
  require('dap-python').setup(pkg.get_path('debugpy', '/venv/bin/python', { warn = false }))
  require('dap-go').setup()

  -- DAP signs
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  for name, sign in pairs(icons.dap) do
    sign = type(sign) == 'table' and sign or { sign }
    vim.fn.sign_define('Dap' .. name, {
      text = sign[1],
      texthl = sign[2] or 'DiagnosticInfo',
      linehl = sign[3],
      numhl = sign[3],
    })
  end

  -- VSCode launch.json
  local vscode = require('dap.ext.vscode')
  vscode.json_decode = function(str)
    str = str:gsub('//[^\n]*', ''):gsub('/%*.-%*/', '')
    return vim.json.decode(str)
  end

  -- C# / .NET
  if not dap.adapters['netcoredbg'] then
    dap.adapters['netcoredbg'] = {
      type = 'executable',
      command = vim.fn.exepath('netcoredbg'),
      args = { '--interpreter=vscode' },
    }
  end
  for _, lang in ipairs({ 'cs', 'fsharp', 'vb' }) do
    if not dap.configurations[lang] then
      dap.configurations[lang] = {
        {
          type = 'netcoredbg',
          name = 'Launch file',
          request = 'launch',
          program = function() return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file') end,
          cwd = '${workspaceFolder}',
        },
      }
    end
  end

  -- Go
  vscode.type_to_filetypes['delve'] = { 'go' }
  vscode.type_to_filetypes['go'] = { 'go' }

  -- Python
  vscode.type_to_filetypes['python'] = { 'python' }

  -- JavaScript / TypeScript
  if not dap.adapters['pwa-node'] then
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          pkg.get_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
          '${port}',
        },
      },
    }
  end
  if not dap.adapters['node'] then
    dap.adapters['node'] = function(cb, cfg)
      if cfg.type == 'node' then cfg.type = 'pwa-node' end
      local native = dap.adapters['pwa-node']
      if type(native) == 'function' then
        native(cb, cfg)
      else
        cb(native)
      end
    end
  end
  local js_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
  vscode.type_to_filetypes['node'] = js_filetypes
  vscode.type_to_filetypes['pwa-node'] = js_filetypes
  for _, lang in ipairs(js_filetypes) do
    dap.configurations[lang] = {
      {
        name = 'Launch File',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to Process',
        type = 'pwa-node',
        request = 'attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      },
    }
  end

  -- DAP UI
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = 'breakpoints', size = 0.2 },
          { id = 'scopes', size = 0.4 },
          { id = 'stacks', size = 0.4 },
        },
        position = 'left',
        size = 40,
      },
      {
        elements = {
          { id = 'repl', size = 0.5 },
          { id = 'console', size = 0.5 },
        },
        position = 'bottom',
        size = 15,
      },
    },
  })
  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
end

local function d(fn)
  return function()
    ensure_init()
    fn()
  end
end

local function get_args(cfg)
  local args = type(cfg.args) == 'function' and (cfg.args() or {}) or cfg.args or {}
  cfg = vim.deepcopy(cfg)
  cfg.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' '))
    return vim.split(vim.fn.expand(new_args), ' ')
  end
  return cfg
end

vim.keymap.set('n', '<F5>', d(function() require('dap').continue() end), { desc = '[F5] continue' })
vim.keymap.set('n', '<F9>', d(function() require('dap').step_out() end), { desc = '[F9] step out' })
vim.keymap.set('n', '<F10>', d(function() require('dap').step_over() end), { desc = '[F10] step over' })
vim.keymap.set('n', '<F11>', d(function() require('dap').step_into() end), { desc = '[F11] step into' })
vim.keymap.set('n', '<F12>', d(function() require('dap').terminate() end), { desc = '[F12] terminate' })
vim.keymap.set(
  'n',
  '<leader>da',
  d(function() require('dap').continue({ before = get_args }) end),
  { desc = 'run with [a]rgs' }
)
vim.keymap.set(
  'n',
  '<leader>db',
  d(function() require('dap').toggle_breakpoint() end),
  { desc = 'toggle [b]reakpoint' }
)
vim.keymap.set(
  'n',
  '<leader>dB',
  d(function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end),
  { desc = 'conditional [B]reakpoint' }
)
vim.keymap.set('n', '<leader>dc', d(function() require('dap').continue() end), { desc = '[c]ontinue' })
vim.keymap.set('n', '<leader>dC', d(function() require('dap').run_to_cursor() end), { desc = 'run to [C]ursor' })
vim.keymap.set('n', '<leader>dg', d(function() require('dap').goto_() end), { desc = '[g]oto line' })
vim.keymap.set('n', '<leader>di', d(function() require('dap').step_into() end), { desc = 'step [i]nto' })
vim.keymap.set('n', '<leader>dl', d(function() require('dap').run_last() end), { desc = 'run [l]ast' })
vim.keymap.set('n', '<leader>do', d(function() require('dap').step_out() end), { desc = 'step [o]ut' })
vim.keymap.set('n', '<leader>dO', d(function() require('dap').step_over() end), { desc = 'step [O]ver' })
vim.keymap.set('n', '<leader>dp', d(function() require('dap').pause() end), { desc = '[p]ause' })
vim.keymap.set('n', '<leader>dr', d(function() require('dap').repl.toggle() end), { desc = 'toggle [r]EPL' })
vim.keymap.set('n', '<leader>ds', d(function() require('dap').session() end), { desc = '[s]ession' })
vim.keymap.set('n', '<leader>dt', d(function() require('dap').terminate() end), { desc = '[t]erminate' })
vim.keymap.set('n', '<leader>dw', d(function() require('dap.ui.widgets').hover() end), { desc = '[w]idgets' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', d(function() require('dapui').eval() end), { desc = '[e]val' })
vim.keymap.set('n', '<leader>du', d(function() require('dapui').toggle({}) end), { desc = '[u]i' })
