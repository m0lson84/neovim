--[[
Markdown language support
--]]

return {

  -- Add languages to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'markdown', 'markdown_inline', 'mermaid' } },
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

  -- Document preview
  {
    'jannis-baum/vivify.vim',
    opts = {
      filetypes = { 'vimwiki' },
    },
    keys = {
      { '<leader>m', '', ft = 'markdown', desc = '[m]arkdown' },
      { '<leader>mp', '<cmd>Vivify<cr>', ft = 'markdown', desc = '[p]review' },
    },
    config = function(_, opts) vim.g.vivify_filetypes = opts.filetypes or {} end,
  },
  {
    'wallpants/github-preview.nvim',
    opts = {
      theme = { name = 'dark' },
      cursor_line = { disable = true },
      log_level = 'debug',
    },
    keys = {
      { '<leader>mg', '<cmd>GithubPreviewToggle<cr>', ft = 'markdown', desc = '[g]ithub preview' },
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
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
    },
  },
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        providers = {
          markdown = {
            name = 'RenderMarkdown',
            module = 'render-markdown.integ.blink',
            fallbacks = { 'lsp' },
          },
        },
      },
    },
  },

  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>m', group = '[m]arkdown', icon = { icon = '', color = 'grey' } },
      },
    },
  },
}
