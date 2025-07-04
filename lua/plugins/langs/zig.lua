--[[
Zig language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'zig' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      settings = {
        zls = {
          single_file_support = true,
        },
      },
      servers = {
        zls = {},
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        zig = { 'zigfmt' },
      },
    },
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = {
      'lawrence-laz/neotest-zig',
    },
    opts = {
      adapters = {
        ['neotest-zig'] = {
          dap = {
            adapters = 'lldb-dap',
          },
        },
      },
    },
  },
}
