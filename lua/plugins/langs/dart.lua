--[[
Dart language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'dart' } },
  },

  -- Configure flutter tools
  {
    'akinsho/flutter-tools.nvim',
    opts = {
      fvm = true,
      dev_log = {
        enabled = false,
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require('dap').configurations.dart = {
            {
              name = 'Flutter: launch',
              request = 'launch',
              type = 'dart',
              program = '${workspaceFolder}/lib/main.dart',
              args = {},
            },
          }
          require('dap.ext.vscode').load_launchjs()
        end,
      },
      ui = {
        border = 'single',
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        dart_format = {
          args = function(_, ctx)
            local line_length = vim.bo[ctx.buf].textwidth or 80
            return { 'format', '-l', string.format('%d', line_length), '--fix' }
          end,
        },
      },
      formatters_by_ft = {
        dart = { 'dart_format' },
      },
    },
  },
}
