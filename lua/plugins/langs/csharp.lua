--[[
C# language support
--]]

--- Find all references handler
local function find_all_references()
  return function() require('omnisharp_extended').lsp_references() end
end

--- Go to definition handler
local function goto_definition()
  return function() require('omnisharp_extended').lsp_definitions() end
end

--- Go to implementation handler
local function goto_implementation()
  return function() require('omnisharp_extended').lsp_implementation() end
end
--- Go to type definition handler
local function goto_type_definition()
  return function() require('omnisharp_extended').lsp_type_definition() end
end

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'c_sharp' } },
  },

  -- Configure language server
  { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        omnisharp = {
          keys = {
            { 'gd', goto_definition(), desc = 'Goto Definition' },
            { 'gi', goto_implementation(), desc = 'Goto Implementation' },
            { 'gr', find_all_references(), desc = 'Find All References' },
            { '<leader>D', goto_type_definition(), desc = 'Goto Type Definition' },
          },
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
            },
          },
        },
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        cs = { 'csharpier' },
      },
    },
  },

  -- Configure debug adapter
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'mason-org/mason.nvim', opts = { ensure_installed = { 'netcoredbg' } } },
    },
    opts = function(_, opts)
      local dap = require('dap')
      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
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
      return opts
    end,
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = { 'nsidorenco/neotest-vstest' },
    opts = {
      adapters = {
        ['neotest-vstest'] = {
          dap_settings = {
            type = 'netcoredbg',
          },
        },
      },
    },
  },

  -- Code annotations and documentation
  {
    'danymat/neogen',
    opts = {
      languages = {
        cs = { template = { annotation_convention = 'xmldoc' } },
      },
    },
  },
}
