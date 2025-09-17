--[[
Rust language support
--]]

--- Configure keymap for rust code actions
---@param bufnr boolean|integer The current buffer
local function code_actions(bufnr)
  vim.keymap.set(
    'n',
    '<leader>cA',
    function() vim.cmd.RustLsp('codeAction') end,
    { desc = 'rust [A]ctions', buffer = bufnr }
  )
end

--- Configure keymap for rust debuggables
---@param bufnr boolean|integer The current buffer
local function debuggables(bufnr)
  vim.keymap.set(
    'n',
    '<leader>dr',
    function() vim.cmd.RustLsp('debuggables') end,
    { desc = '[r]ust debuggables', buffer = bufnr }
  )
end

--- Hover action for cargo.toml files
local function hover_action()
  if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ron', 'rust' } },
  },

  -- Configure language plugin
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    opts = {
      server = {
        load_vscode_settings = true,
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = true,
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
        on_attach = function(_, bufnr)
          code_actions(bufnr)
          debuggables(bufnr)
        end,
      },
    },
    config = function(_, opts) vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts) end,
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        rust_analyzer = { enabled = false },
        taplo = {
          keys = {
            { 'K', hover_action, desc = 'show crate docs' },
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
        rust = { 'rustfmt' },
      },
    },
  },

  -- Configure test runner
  {
    'nvim-neotest/neotest',
    opts = {
      adapters = {
        ['rustaceanvim.neotest'] = {},
      },
    },
  },

  -- Code annotations and documentation
  {
    'danymat/neogen',
    opts = {
      languages = {
        rust = { template = { annotation_convention = 'rustdoc' } },
      },
    },
  },

  -- Dependency management
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
