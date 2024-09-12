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

  -- Markdown preview
  {
    'jannis-baum/vivify.vim',
  },
  {
    'Tweekism/markdown-preview.nvim',
    event = { 'BufRead' },
    build = function()
      require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      { '<leader>m', '', ft = 'markdown', desc = '[m]arkdown' },
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', ft = 'markdown', desc = '[p]review' },
    },
    config = function()
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_page_title = 'Markdown Preview'
    end,
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
    dependencies = { 'echasnovski/mini.icons' },
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
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>m', group = '[m]arkdown', icon = { icon = '', color = 'grey' } },
      },
    },
  },
}
