--[[
nvim-dap (https://github.com/mfussenegger/nvim-dap)
--]]

--- Add a conditional breakpoint
local function conditional_breakpoint() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end

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
    keys = function()
      local dap = require('dap')
      local widgets = require('dap.ui.widgets')
      return {
        { '<leader>db', dap.toggle_breakpoint, desc = 'toggle [b]reakpoint' },
        { '<leader>dB', conditional_breakpoint, desc = 'conditional [B]reakpoint' },
        { '<leader>dc', dap.continue, desc = '[c]ontinue' },
        { '<leader>da', function() dap.continue({ before = get_args }) end, desc = 'run with [a]rgs' },
        { '<leader>dC', dap.run_to_cursor, desc = 'run to [C]ursor' },
        { '<leader>dg', dap.goto_, desc = '[g]oto line' },
        { '<leader>di', dap.step_into, desc = 'step [i]nto' },
        { '<leader>dl', dap.run_last, desc = 'run [l]ast' },
        { '<leader>do', dap.step_out, desc = 'step [o]ut' },
        { '<leader>dO', dap.step_over, desc = 'step [O]ver' },
        { '<leader>dp', dap.pause, desc = '[p]ause' },
        { '<leader>dr', dap.repl.toggle, desc = 'toggle [r]EPL' },
        { '<leader>ds', dap.session, desc = '[s]ession' },
        { '<leader>dt', dap.terminate, desc = '[t]erminate' },
        { '<leader>dw', widgets.hover, desc = '[w]idgets' },
      }
    end,

    config = function()
      require('mason-nvim-dap').setup(utils.plugin.opts('mason-nvim-dap.nvim'))

      vim.api.nvim_set_hl(0, 'DapStoppedLine', {
        default = true,
        link = 'Visual',
      })

      for name, sign in pairs(config.icons.dap) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define('Dap' .. name, {
          text = sign[1],
          texthl = sign[2] or 'DiagnosticInfo',
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      -- setup dap config by VSCode launch.json file
      local vscode = require('dap.ext.vscode')
      local json = require('plenary.json')
      vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end
    end,
  },

  -- fancy UI for the debugger
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    opts = {},
    keys = {
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
      { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
    },
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
    end,
  },

  -- mason.nvim integration
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    },
    config = function() end,
  },
}
