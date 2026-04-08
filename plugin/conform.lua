--[[
conform.nvim (https://github.com/stevearc/conform.nvim)
--]]

local format = require('util.format')

vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'

require('conform').setup({
  default_format_opts = { timeout_ms = 3000, async = false, quiet = false, lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 3000 },

  formatters_by_ft = {
    bash = { 'shfmt' },
    cs = { 'csharpier' },
    css = { 'prettierd' },
    dotenv = { 'shfmt' },
    fish = { 'fish_indent' },
    go = { 'golangci-lint' },
    graphql = { 'prettierd' },
    handlebars = { 'prettierd' },
    html = { 'prettierd' },
    hurl = { 'hurlfmt' },
    javascript = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    javascriptreact = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    json = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    jsonc = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    less = { 'prettierd' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    markdown_mdx = { 'prettierd' },
    proto = { 'buf' },
    python = { 'ruff_fix', 'ruff_format' },
    rust = { 'rustfmt' },
    scss = { 'prettierd' },
    sh = { 'shfmt' },
    sql = { 'sqlfluff', 'sqlfmt' },
    templ = { 'templ', 'injected' },
    toml = { 'taplo' },
    typescript = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    typescriptreact = function(bufnr) return { format.get(bufnr, 'biome-check', 'prettierd') } end,
    typst = { 'typstyle' },
    vue = { 'prettierd' },
    yaml = { 'prettierd' },
    zig = { 'zigfmt' },
    zsh = { 'shfmt' },
  },

  formatters = {
    injected = { options = { ignore_errors = true } },
    ['biome-check'] = {},
    buf = {},
    csharpier = { command = 'dotnet', args = { 'csharpier', 'format', '--write-stdout' }, stdin = true },
    ['golangci-lint'] = {},
    hurlfmt = {},
    rustfmt = {},
    shfmt = {
      prepend_args = function(_, ctx)
        local indent_size = vim.bo[ctx.buf].shiftwidth or 2
        return { '-i', string.format('%d', indent_size), '-ci' }
      end,
    },
    sqlfmt = {},
    sqlfluff = { args = { 'fix', '-' } },
    stylua = {},
    taplo = {
      args = function(_, ctx)
        local line_length = vim.bo[ctx.buf].textwidth or 120
        return {
          'format',
          '--option',
          string.format('column_width=%d', line_length),
          '--option',
          'align_entries=true',
          '--option',
          'reorder_arrays=true',
          '-',
        }
      end,
    },
    templ = {},
    typstyle = {
      prepend_args = function(_, ctx)
        local line_length = vim.bo[ctx.buf].textwidth or 120
        return { '-l', tostring(line_length), '--wrap-text' }
      end,
    },
  },
})

vim.keymap.set(
  { 'n', 'v' },
  '<leader>cf',
  function() require('conform').format({ async = true }) end,
  { desc = '[f]ormat buffer' }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>cF',
  function() require('conform').format({ formatters = { 'injected' } }) end,
  { desc = '[F]ormat injected langs' }
)
vim.keymap.set('n', '<leader>ic', '<cmd>ConformInfo<cr>', { desc = '[c]onform' })
