--[[
Ruby language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ruby' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruby_lsp = { mason = false },
        rubocop = { mason = false },
      },
    },
  },

  -- Configure linters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        eruby = { 'erb_lint' },
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ruby = { 'rubocop' },
        eruby = { 'erb_format' },
      },
    },
  },

  -- Configure debug adapter
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      'suketa/nvim-dap-ruby',
      config = function() require('dap-ruby').setup() end,
    },
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = { 'zidhuss/neotest-minitest' },
    opts = {
      adapters = {
        ['neotest-minitest'] = {},
      },
    },
  },
}
