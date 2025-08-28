--[[
Golang language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'go', 'gomod', 'gosum', 'gotmpl', 'gowork' } },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              directoryFilters = { '-.git', '-.idea', '-node_modules', '-.vscode', '-.vscode-test' },
              templateExtensions = { 'gotmpl', 'tmpl' },
              semanticTokens = true,
            },
          },
        },
      },
      setup = {
        gopls = function(_, _)
          utils.lsp.on_attach(function(client, _)
            if client.server_capabilities.semanticTokensProvider then return end
            local semantic = client.config.capabilities.textDocument.semanticTokens
            if not semantic then return end
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              range = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
            }
          end, 'gopls')
        end,
      },
    },
  },

  -- Configure linters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        go = { 'golangcilint' },
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'golangci-lint' },
      },
    },
  },

  -- Configure debug adapter
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'mason-org/mason.nvim', opts = { ensure_installed = { 'delve' } } },
      { 'leoluz/nvim-dap-go', opts = {} },
    },
    opts = function()
      local vscode = require('dap.ext.vscode')
      vscode.type_to_filetypes['delve'] = { 'go' }
      vscode.type_to_filetypes['go'] = { 'go' }
    end,
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = { 'fredrikaverpil/neotest-golang' },
    opts = {
      adapters = {
        ['neotest-golang'] = {
          dap_go_enabled = true,
          warn_test_not_executed = false,
        },
      },
    },
  },

  -- Code annotations and documentation
  {
    'danymat/neogen',
    opts = {
      languages = {
        go = { template = { annotation_convention = 'godoc' } },
      },
    },
  },

  -- Filetype icons
  {
    'nvim-mini/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    },
  },
}
