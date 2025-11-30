--[[
Markdown language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'markdown', 'markdown_inline', 'mermaid' },
    },
  },

  -- Configure language server
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Configure linters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
      },
    },
  },

  -- Configure formatters
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        markdown = { 'prettierd' },
        markdown_mdx = { 'prettierd' },
      },
    },
  },

  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    ft = { 'markdown', 'norg', 'rmd', 'org' },
    opts = {
      file_types = { 'markdown', 'norg', 'rmd', 'org' },
      heading = { enabled = false },
      latex = { enabled = false },
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },

  -- Document preview
  {
    'jannis-baum/vivify.vim',
    opts = {
      filetypes = { 'vimwiki' },
    },
    keys = {
      { '<leader>cp', '<cmd>Vivify<cr>', ft = 'markdown', desc = '[p]review doc' },
    },
    config = function(_, opts) vim.g.vivify_filetypes = opts.filetypes or {} end,
  },
}
