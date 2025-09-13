--[[
nvim-lspconfig (https://github.com/neovim/nvim-lspconfig)
--]]

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
    },
    event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = function(diagnostic)
            local icons = config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
            end
          end,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = config.icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = { enabled = true },
      codelens = { enabled = false },
      document_highlight = { enabled = true },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = utils.autocmd.group('lsp_attach'),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
          end

          map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
          map('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
          map('gr', vim.lsp.buf.references, '[g]oto [r]eferences')
          map('gI', vim.lsp.buf.implementation, '[g]oto [I]mplementation')
          map('gy', vim.lsp.buf.type_definition, '[g]oto t[y]pe definition')
          map('K', vim.lsp.buf.hover, 'hover')
          map('gK', vim.lsp.buf.signature_help, 'signature help')
          map('<c-k>', vim.lsp.buf.signature_help, 'signature help', { 'i' })
          map('<leader>ca', vim.lsp.buf.code_action, 'code [a]ction', { 'n', 'x' })
          map('<leader>cr', vim.lsp.buf.rename, '[r]ename')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then return end

          local lsp_methods = vim.lsp.protocol.Methods

          -- document highlights
          if client:supports_method(lsp_methods.textDocument_documentHighlight, event.buf) then
            local highlight_group = utils.autocmd.group('lsp_highlight')
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = utils.autocmd.group('lsp_detach'),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'local_lsp_highlight', buffer = e.buf })
              end,
            })
          end

          -- inlay hints
          if opts.inlay_hints.enabled and client:supports_method(lsp_methods.textDocument_inlayHint, event.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end

          -- code lens
          if opts.codelens.enabled and vim.lsp.codelens then
            utils.lsp.on_supports_method(lsp_methods.textDocument_codeLens, function(_, buffer)
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                buffer = buffer,
                callback = vim.lsp.codelens.refresh,
              })
            end)
          end
        end,
      })

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local function setup(server)
        local config = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, opts.servers[server] or {})
        if config.enabled == false then return end

        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        if opts.setup[server] then
          if opts.setup[server](server, config) then return end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, config) then return end
        end
        vim.lsp.config(server, config)
      end

      local mason = require('mason-lspconfig')
      local servers = vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package)

      local ensure_installed = {} ---@type string[]
      for server, config in pairs(opts.servers) do
        if config then
          config = config == true and {} or config
          if config.enabled ~= false then
            if config.mason == false or not vim.tbl_contains(servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      mason.setup({
        automatic_enable = {
          exclude = { 'rust_analyzer' },
        },
        ensure_installed = vim.tbl_deep_extend(
          'force',
          ensure_installed,
          utils.plugin.opts('mason-lspconfig.nvim').ensure_installed or {}
        ),
      })
    end,
    keys = {
      { '<leader>il', '<cmd>LspInfo<cr>', desc = '[l]sp' },
    },
  },
}
