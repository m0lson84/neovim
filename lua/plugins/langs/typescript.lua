--[[
Javascript / Typescript language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'javascript', 'typescript', 'tsx' } },
  },

  -- Configure language server
  {
    'yioneko/nvim-vtsls',
    lazy = true,
    opts = {},
    config = function(_, opts) require('vtsls').config(opts) end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local vtsls = require('vtsls')
      local lang = {
        updateImportsOnFileMove = {
          enabled = 'always',
        },
        suggest = {
          completeFunctionCalls = true,
          includeCompletionsForImportStatements = true,
        },
      }
      opts.servers.vtsls = {
        settings = {
          complete_function_calls = true,
          vtsls = {
            autoUseWorkspaceTsdk = true,
            enableMoveToFileCodeAction = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          javascript = lang,
          typescript = lang,
        },
        keys = {
          { 'gD', function() vtsls.commands.goto_source_definition(0) end, desc = 'goto source [D]efinition' },
          { 'gR', function() vtsls.commands.file_references(0) end, desc = 'file [R]eferences' },
          { '<leader>cD', function() vtsls.commands.fix_all(0) end, desc = 'fix all [D]iagnostics' },
          { '<leader>cM', function() vtsls.commands.add_missing_imports(0) end, desc = 'add [M]issing imports' },
          { '<leader>co', function() vtsls.commands.organize_imports(0) end, desc = '[o]rganize imports' },
        },
      }
      return opts
    end,
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
        javascriptreact = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
        typescript = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
        typescriptreact = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
      },
    },
  },

  -- Configure debug adapter
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'mason-org/mason.nvim', opts = { ensure_installed = { 'js-debug-adapter' } } },
    },
    opts = function(_, opts)
      local dap = require('dap')

      -- Configure node.js adapter
      if not dap.adapters['pwa-node'] then
        require('dap').adapters['pwa-node'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'node',
            args = {
              utils.pkg.get_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
              '${port}',
            },
          },
        }
      end

      if not dap.adapters['node'] then
        dap.adapters['node'] = function(cb, config)
          if config.type == 'node' then config.type = 'pwa-node' end
          local nativeAdapter = dap.adapters['pwa-node']
          if type(nativeAdapter) == 'function' then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

      local vscode = require('dap.ext.vscode')
      vscode.type_to_filetypes['node'] = filetypes
      vscode.type_to_filetypes['pwa-node'] = filetypes

      -- Define default configurations
      for _, lang in ipairs(filetypes) do
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

      return opts
    end,
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    dependencies = { 'nvim-neotest/neotest-jest' },
    opts = {
      adapters = {
        ['neotest-jest'] = {
          jestCommand = 'npm test --',
          jestConfigFile = function()
            local file = vim.fn.expand('%:p')
            if string.find(file, '/packages/') then return string.match(file, '(.-/[^/]+/)src') .. 'jest.config.ts' end
            return vim.fn.getcwd() .. '/jest.config.ts'
          end,
          cwd = function()
            local file = vim.fn.expand('%:p')
            if string.find(file, '/packages/') then return string.match(file, '(.-/[^/]+/)src') end
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },

  -- Code annotations and documentation
  {
    'danymat/neogen',
    opts = function(_, opts)
      opts.languages = utils.table.extend_keys(
        opts.languages or {},
        { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        { template = { annotation_convention = 'jsdoc' } }
      )
    end,
  },

  -- Filetype icons
  {
    'echasnovski/mini.icons',
    opts = {
      file = {
        ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsPurple' },
        ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
        ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsPurple' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
    },
  },
}
