--[[
LSP configuration
--]]

local autocmd = require('util.autocmd')
local icons = require('config.icons')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/b0o/SchemaStore.nvim',
})

vim.lsp.config('*', {
  capabilities = {
    workspace = {
      fileOperations = { didRename = true, willRename = true },
    },
  },
  root_markers = { '.git' },
})

vim.lsp.enable(require('util.lsp').servers())

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = function(diagnostic)
      local diag_icons = icons.diagnostics
      for d, icon in pairs(diag_icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
      end
      return '●'
    end,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = autocmd.group('lsp_attach'),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buf = event.buf, desc = 'lsp: ' .. desc })
    end

    map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
    map('gD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    local methods = vim.lsp.protocol.Methods

    -- Inlay hints
    if client:supports_method(methods.textDocument_inlayHint, event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    -- Code lenses
    if client:supports_method(methods.textDocument_codeLens, event.buf) then
      vim.lsp.codelens.enable(true, { bufnr = event.buf })
    end

    -- Per-server attach hooks
    if client.name == 'gopls' then
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
    end

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
      map(
        '<leader>co',
        function()
          vim.lsp.buf.code_action({
            context = { only = { 'source.organizeImports' }, diagnostics = {} },
            apply = true,
          })
        end,
        '[o]rganize imports'
      )
    end
  end,
})

vim.keymap.set('n', '<leader>il', '<cmd>checkhealth vim.lsp<cr>', { desc = '[l]sp' })
