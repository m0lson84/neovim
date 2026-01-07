--[[
JSON language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'json', 'json5' },
    },
  },

  -- Schema store support
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false,
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
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
        json = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
        jsonc = function(bufnr) return { utils.format.get(bufnr, 'biome-check', 'prettierd') } end,
      },
    },
  },

  -- Filetype icons
  {
    'nvim-mini/mini.icons',
    opts = {
      extension = {
        ['json.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
      },
    },
  },
}
