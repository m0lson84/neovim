--[[
Python language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'python', 'rst' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      settings = {
        basedpyright = { disableOrganizeImports = true },
        python = { analysis = { ignore = { '*' } } },
      },
      servers = {
        basedpyright = {},
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_fix', 'ruff_format' },
      },
    },
  },

  -- Configure debug adapter
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'mfussenegger/nvim-dap-python',
        config = function() require('dap-python').setup(utils.pkg.get_path('debugpy', '/venv/bin/python')) end,
      },
    },
    opts = function()
      local vscode = require('dap.ext.vscode')
      vscode.type_to_filetypes['python'] = { 'python' }
    end,
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = { 'nvim-neotest/neotest-python' },
    opts = {
      adapters = {
        ['neotest-python'] = {
          runner = 'pytest',
          python = './.venv/bin/python',
          args = { '--log-level', 'DEBUG' },
          dap = { justMyCode = true },
        },
      },
    },
  },

  -- Code annotations and documentation
  {
    'danymat/neogen',
    opts = {
      languages = {
        python = { template = { annotation_convention = 'google_docstrings' } },
      },
    },
  },

  -- Activate virtual environment
  {
    'linux-cultist/venv-selector.nvim',
    ft = 'python',
    opts = {},
    keys = {
      { '<leader>cv', '<cmd>:VenvSelect<cr>', ft = 'python', desc = 'Select VirtualEnv' },
    },
  },

  -- Filetype icons
  {
    'nvim-mini/mini.icons',
    opts = {
      file = {
        ['.python-version'] = { glyph = '󰌠', hl = 'MiniIconsYellow' },
      },
    },
  },
}
