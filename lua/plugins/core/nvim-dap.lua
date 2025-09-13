--[[
nvim-dap (https://github.com/mfussenegger/nvim-dap)
--]]

--- Add a conditional breakpoint
local function conditional_breakpoint()
  local condition = vim.fn.input('Breakpoint condition: ')
  require('dap').set_breakpoint(condition)
end

--- Get args from user input
---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui' },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    config = function()
      require('mason-nvim-dap').setup(utils.plugin.opts('mason-nvim-dap.nvim'))

      vim.api.nvim_set_hl(0, 'DapStoppedLine', {
        default = true,
        link = 'Visual',
      })

      -- Configure virtual text
      for name, sign in pairs(config.icons.dap) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define('Dap' .. name, {
          text = sign[1],
          texthl = sign[2] or 'DiagnosticInfo',
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      -- Setup dap config by VSCode launch.json file
      local vscode = require('dap.ext.vscode')
      local json = require('plenary.json')
      vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end
    end,
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = '[F5] continue' },
      { '<F9>', function() require('dap').step_out() end, desc = '[F9] step out' },
      { '<F10>', function() require('dap').step_over() end, desc = '[F10] step over' },
      { '<F11>', function() require('dap').step_into() end, desc = '[F11] step into' },
      { '<F12>', function() require('dap').step_over() end, desc = '[F12] terminate' },
      { '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = 'run with [a]rgs' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'toggle [b]reakpoint' },
      { '<leader>dB', conditional_breakpoint, desc = 'conditional [B]reakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = '[c]ontinue' },
      { '<leader>dc', function() require('dap').continue() end, desc = '[c]ontinue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'run to [C]ursor' },
      { '<leader>dg', function() require('dap').goto_() end, desc = '[g]oto line' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'step [i]nto' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'run [l]ast' },
      { '<leader>do', function() require('dap').step_out() end, desc = 'step [o]ut' },
      { '<leader>dO', function() require('dap').step_over() end, desc = 'step [O]ver' },
      { '<leader>dp', function() require('dap').pause() end, desc = '[p]ause' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'toggle [r]EPL' },
      { '<leader>ds', function() require('dap').session() end, desc = '[s]ession' },
      { '<leader>dt', function() require('dap').terminate() end, desc = '[t]erminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = '[w]idgets' },
    },
  },

  -- fancy UI for the debugger
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    opts = {
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
    },
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
    end,
    keys = {
      { '<leader>de', function() require('dapui').eval() end, desc = '[e]val', mode = { 'n', 'v' } },
      { '<leader>du', function() require('dapui').toggle({}) end, desc = '[u]i' },
    },
  },

  -- mason.nvim integration
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    },
    config = function() end,
  },
}
