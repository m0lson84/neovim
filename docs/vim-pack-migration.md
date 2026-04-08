# Migration Plan: lazy.nvim to vim.pack

## Design Decisions

- **`vim.pack.add()` co-located with plugin config** in each `plugin/*.lua` file
- **No numeric filename prefixes** -- only the colorscheme needs early loading, handled via `require()` in `init.lua`
- **Native `lsp/*.lua` files** instead of a monolithic lspconfig file -- drops the `nvim-lspconfig` dependency
- **Globals replaced with `require()`** -- no more `_G.config` or `_G.utils`
- **1-to-1 plugin-to-file mapping** -- no distributed spec merging, no `formatters/`/`linters/`/`langs/` directories

---

## New Directory Structure

```
~/.config/nvim/
├── init.lua
├── nvim-pack-lock.json                     # Managed by vim.pack (replaces lazy-lock.json)
├── lua/
│   ├── config/
│   │   ├── icons.lua                       # Shared icon definitions
│   │   ├── colorscheme.lua                 # Colorscheme (tokyonight) setup
│   │   ├── options.lua                     # Core options (minor edits)
│   │   ├── autocmds.lua                    # Auto commands (minor edits + PackChanged hook)
│   │   ├── commands.lua                    # NEW: user commands (vim.pack management, etc.)
│   │   └── keymaps.lua                     # Global keymaps (minor edits)
│   └── util/
│       ├── format.lua                      # Trimmed: only get() retained
│       └── pkg.lua                         # Remove lazy.nvim headless check
├── lsp/                                    # NEW: native LSP server configs
│   ├── bashls.lua
│   ├── bicep.lua
│   ├── biome.lua
│   ├── buf_ls.lua
│   ├── copilot.lua
│   ├── cssls.lua
│   ├── cspell_ls.lua
│   ├── docker_compose_language_service.lua
│   ├── dockerls.lua
│   ├── eslint.lua
│   ├── fish_lsp.lua
│   ├── gopls.lua
│   ├── html.lua
│   ├── jsonls.lua
│   ├── lua_ls.lua
│   ├── marksman.lua
│   ├── omnisharp.lua
│   ├── ruff.lua
│   ├── tailwindcss.lua
│   ├── taplo.lua
│   ├── templ.lua
│   ├── tinymist.lua
│   ├── tsgo.lua
│   ├── ty.lua
│   ├── yamlls.lua
│   └── zls.lua
├── plugin/                                 # NEW: auto-sourced plugin configs
│   ├── blink.lua
│   ├── bufferline.lua
│   ├── conform.lua
│   ├── crates.lua
│   ├── diffview.lua
│   ├── dressing.lua
│   ├── edgy.lua
│   ├── flash.lua
│   ├── gitsigns.lua
│   ├── grug-far.lua
│   ├── hurl.lua
│   ├── kulala.lua
│   ├── lazydev.lua
│   ├── lsp.lua
│   ├── lualine.lua
│   ├── mason.lua
│   ├── mini-ai.lua
│   ├── mini-icons.lua
│   ├── mini-indentscope.lua
│   ├── mini-pairs.lua
│   ├── mini-starter.lua
│   ├── mini-surround.lua
│   ├── neogen.lua
│   ├── neotest.lua
│   ├── noice.lua
│   ├── nvim-dap.lua
│   ├── nvim-lint.lua
│   ├── nvim-treesitter.lua
│   ├── nvim-treesitter-context.lua
│   ├── nvim-treesitter-textobjects.lua
│   ├── opencode.lua
│   ├── persistence.lua
│   ├── plenary.lua
│   ├── render-markdown.lua
│   ├── rustaceanvim.lua
│   ├── snacks.lua
│   ├── todo-comments.lua
│   ├── trouble.lua
│   ├── ts-comments.lua
│   ├── typst-preview.lua
│   ├── venv-selector.lua
│   ├── vim-sleuth.lua
│   ├── virt-column.lua
│   ├── vivify.lua
│   ├── which-key.lua
│   └── yanky.lua
```

---

## Files to Delete

| File/Directory               | Reason                                                                   |
| ---------------------------- | ------------------------------------------------------------------------ |
| `lua/config/lazy.lua`        | lazy.nvim bootstrap, no longer needed                                    |
| `lua/config/init.lua`        | Icons table moved to `lua/config/icons.lua`; metatable proxy removed     |
| `lazy-lock.json`             | Replaced by `nvim-pack-lock.json`                                        |
| `lua/plugins/` (entire tree) | Replaced by `plugin/` and `lsp/`                                         |
| `lua/util/init.lua`          | Lazy-loader proxy for submodules; no submodules left to proxy            |
| `lua/util/autocmd.lua`       | One-liner `augroup` wrapper; inlined as local helper in 2 files          |
| `lua/util/dir.lua`           | Only consumer (`root.lua`) is deleted; `vim.fs.find()` covers this       |
| `lua/util/file.lua`          | Entirely unused -- zero external call sites                              |
| `lua/util/lsp.lua`           | `on_attach` inlines trivially; rest is unused or dead code paths         |
| `lua/util/path.lua`          | Only consumer (`root.lua`) is deleted; `vim.fs.normalize()` covers this  |
| `lua/util/plugin.lua`        | Only wraps `require('lazy.core.config')`                                 |
| `lua/util/root.lua`          | Replaced by `vim.fs.root(0, '.git') or vim.uv.cwd()`                     |
| `lua/util/string.lua`        | Entirely unused -- zero external call sites                              |
| `lua/util/table.lua`         | Single call site (`extend_keys`) inlined in `plugin/neogen.lua`          |
| `lua/util/treesitter.lua`    | `have()` replaced by 4-line local helper in `plugin/nvim-treesitter.lua` |
| `lua/util/ui.lua`            | `fg()` replaced by 4-line local helper in `plugin/lualine.lua`           |

---

## Dependencies Dropped

| Dependency          | Reason                                                                   |
| ------------------- | ------------------------------------------------------------------------ |
| `lazy.nvim`         | Replaced by `vim.pack`                                                   |
| `nvim-lspconfig`    | Replaced by native `lsp/*.lua` + `vim.lsp.config()` + `vim.lsp.enable()` |
| `nvim-web-devicons` | Already mocked by `mini.icons`                                           |

---

## Phase 1: `init.lua`

```lua
-- Enable fast module loading
vim.loader.enable()

-- Load configuration
require('config.options')
require('config.autocmds')
require('config.commands')
require('config.keymaps')
require('config.colorscheme')
```

After this runs, Neovim automatically sources every file in `plugin/` alphabetically.
The colorscheme is already applied via `require()` before `plugin/` files run.

---

## Phase 2: `lua/config/colorscheme.lua` (New File)

```lua
--[[
Colorscheme configuration
--]]

vim.pack.add({ 'https://github.com/folke/tokyonight.nvim' })

require('tokyonight').setup({
  style = 'night',
  plugins = { markdown = true },
  on_colors = function(colors)
    local util = require('tokyonight.util')
    colors.bg = colors.bg_dark
    colors.border = util.blend(colors.dark3, 0.9, colors.fg_dark)
    colors.border_highlight = util.blend(colors.blue1, 0.8, colors.bg)
    colors.unused = util.blend(colors.terminal_black, 0.6, colors.fg_dark)
  end,
  on_highlights = function(highlights, colors)
    highlights.ColorColumn = { bg = colors.fg }
    highlights.DiagnosticUnnecessary = { fg = colors.unused, bg = colors.none }
    highlights.DiagnosticVirtualTextError = { fg = colors.error, bg = colors.none }
    highlights.DiagnosticVirtualTextWarn = { fg = colors.warning, bg = colors.none }
    highlights.DiagnosticVirtualTextInfo = { fg = colors.info, bg = colors.none }
    highlights.DiagnosticVirtualTextHint = { fg = colors.hint, bg = colors.none }
    highlights.LspInlayHint = { fg = colors.dark3, bg = colors.none }
    highlights.BlinkCmpDocBorder = { fg = colors.border_highlight, bg = colors.bg_float }
    highlights.BlinkCmpMenuBorder = { fg = colors.border_highlight, bg = colors.bg_float }
  end,
})

vim.cmd.colorscheme('tokyonight')
```

---

## Phase 3: `lua/config/autocmds.lua` Updates

Add the `PackChanged` hook alongside existing autocmds:

```lua
-- vim.pack hooks: run build steps after plugin install/update
vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup('pack_changed'),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
    if name == 'mason.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('mason.nvim') end
      vim.cmd('MasonUpdate')
    end
  end,
})
```

This runs before any `vim.pack.add()` calls since `config/autocmds.lua` is `require()`'d
from `init.lua` before `plugin/` files auto-source.

Additional edits:

- Add `local function augroup(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end` at top
- Replace all `utils.autocmd.group(...)` calls with `augroup(...)`
- Rename `vim.b[buf].lazyvim_last_loc` to `vim.b[buf].last_loc`

---

## Phase 3b: `lua/config/commands.lua` (New File)

User commands for `vim.pack` management and any other custom commands.

```lua
--[[
User commands
--]]

-- vim.pack management
vim.api.nvim_create_user_command('PackUpdate', function() vim.pack.update() end, { desc = 'Update all plugins' })
vim.api.nvim_create_user_command('PackStatus', function() vim.pack.update(nil, { offline = true }) end, { desc = 'Show plugin status' })
vim.api.nvim_create_user_command('PackForceUpdate', function() vim.pack.update(nil, { force = true }) end, { desc = 'Force update all plugins' })
vim.api.nvim_create_user_command('PackRestore', function() vim.pack.update(nil, { target = 'lockfile' }) end, { desc = 'Restore plugins to lockfile state' })
vim.api.nvim_create_user_command('PackDel', function(opts)
  vim.pack.del({ opts.args })
end, { nargs = 1, desc = 'Delete a plugin' })
vim.api.nvim_create_user_command('PackHealth', function() vim.cmd('checkhealth vim.pack') end, { desc = 'Plugin health check' })
```

These provide:

- `:PackStatus` -- opens the confirmation buffer in offline mode showing all plugins
- `:PackUpdate` -- update with review (confirmation buffer with per-plugin diffs)
- `:PackForceUpdate` -- update immediately without review
- `:PackRestore` -- revert plugins to lockfile state
- `:PackDel <name>` -- delete a plugin from disk and lockfile
- `:PackHealth` -- diagnostic report (lockfile issues, out-of-sync state, inactive plugins)

The confirmation buffer (shown by `:PackStatus` and `:PackUpdate`) has built-in navigation
(`]]`/`[[` between plugins) and an in-process LSP server providing document symbols, hover
(change details), and code actions (delete/update/skip per-plugin).

---

## Phase 3c: `lua/config/icons.lua` (New File)

Replaces `lua/config/init.lua`. A plain table of shared icon definitions, without the
metatable proxy.

```lua
--[[
Shared icon definitions
--]]

return {
  misc = {
    dots = '󰇘',
  },
  ft = {
    octo = '',
  },
  dap = {
    Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '.>',
  },
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  kinds = {
    Array = ' ',
    Boolean = '󰨙 ',
    Class = ' ',
    Codeium = '󰘦 ',
    Color = ' ',
    Control = ' ',
    Collapsed = ' ',
    Constant = '󰏿 ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = '󰊕 ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = '󰊕 ',
    Module = ' ',
    Namespace = '󰦮 ',
    Null = ' ',
    Number = '󰎠 ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = '󰆼 ',
    TabNine = '󰏚 ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = '󰀫 ',
  },
}
```

Consumed via `local icons = require('config.icons')` in plugin files that need them.

---

## Phase 4: Global Removal

Remove from `init.lua`:

```lua
-- DELETE these lines:
_G.config = require('config')
_G.utils = require('util')
```

**Files that need `require('config.icons')`:** `plugin/lsp.lua`, `plugin/bufferline.lua`,
`plugin/lualine.lua`, `plugin/nvim-dap.lua`

**Files that need `require('util.format')`:** `plugin/conform.lua`

**Files that need `require('util.pkg')`:** `plugin/nvim-dap.lua`

All other former `utils.*` references are replaced by inlined helpers or native Neovim APIs
(see Phase 5).

---

## Phase 5: Utility Layer Cleanup

After migration, `lua/util/` shrinks from 14 files (~665 lines) to 2 files (~55 lines).
The `_G.utils` global and the `init.lua` proxy are eliminated entirely.

### Delete (12 files)

| File | Reason |
|---|---|
| `init.lua` | Lazy-loader proxy; nothing left to proxy |
| `autocmd.lua` | One-liner; inlined as `local function augroup(name)` in the 2 files that use it |
| `dir.lua` | Only consumer (`root.lua`) is deleted |
| `file.lua` | Entirely unused (zero external call sites) |
| `lsp.lua` | `on_attach()` inlined in `plugin/lsp.lua`; `on_supports_method()` was a dead code path; rest unused |
| `path.lua` | Only consumer (`root.lua`) is deleted |
| `plugin.lua` | Wraps `require('lazy.core.config')` -- must go |
| `root.lua` | Replaced by `vim.fs.root(0, '.git') or vim.uv.cwd()` |
| `string.lua` | Entirely unused (zero external call sites) |
| `table.lua` | Single call site (`extend_keys`) inlined in `plugin/neogen.lua` |
| `treesitter.lua` | `have()` replaced by local helper using `pcall(vim.treesitter.language.inspect, ...)` |
| `ui.lua` | `fg()` replaced by 4-line local helper in `plugin/lualine.lua` |

### Keep (2 files)

**`lua/util/format.lua`** -- trim to only `get()`:

```lua
---@class util.format
local M = {}

--- Get the first configured formatter for the current buffer.
---@param bufnr integer The buffer to format.
---@param ... string[] The list of formatters to try.
---@return string | nil formatter The selected formatter.
function M.get(bufnr, ...)
  for i = 1, select('#', ...) do
    local fmt = select(i, ...)
    local info = require('conform').get_formatter_info(fmt, bufnr)
    if info.available and info.cwd ~= nil then return fmt end
  end
  return select(1, ...)
end

return M
```

Used by `plugin/conform.lua` (6 call sites for JS/TS/JSON formatter selection).

**`lua/util/pkg.lua`** -- remove lazy.nvim dependency:

```lua
---@class util.pkg
local M = {}

--- Gets a path to a package in the Mason registry.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
function M.get_path(pkg, path, opts)
  pcall(require, 'mason')
  local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. '/' .. path
  if opts.warn and not vim.uv.fs_stat(ret) then
    vim.notify(
      ('Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.'):format(pkg, path),
      vim.log.levels.WARN
    )
  end
  return ret
end

return M
```

Used by `plugin/nvim-dap.lua` (2 call sites: `debugpy` and `js-debug-adapter` paths).

### Inline Replacements

**`utils.root()` (2 call sites)** -- replace with `vim.fs.root()`:

```lua
-- config/keymaps.lua (lazygit cwd)
Snacks.lazygit({ cwd = vim.fs.root(0, '.git') or vim.uv.cwd() })

-- plugin/snacks.lua (explorer root)
vim.keymap.set('n', '<leader>fE', explore(vim.fs.root(0, '.git') or vim.uv.cwd()), { desc = '[e]xplorer root' })
```

**`utils.autocmd.group()` (13 call sites in 2 files)** -- define local helper:

```lua
-- At top of config/autocmds.lua and plugin/lsp.lua:
local function augroup(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end
```

**`utils.lsp.on_attach()` (3 call sites)** -- inline as `LspAttach` autocmd:

The `ruff` and `gopls` on_attach hooks are consolidated into `plugin/lsp.lua`'s
`LspAttach` callback (see Phase 7). The `yamlls` on_attach was a no-op `nvim-0.10` check
and is dropped entirely.

**`utils.lsp.on_supports_method()` (1 call site)** -- dead code path:

Called only for codelens support, but `opts.codelens.enabled` is `false`. Removed entirely.

**`utils.ui.fg()` (4 call sites in `plugin/lualine.lua`)** -- local helper:

```lua
local function fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local color = hl.fg or hl.foreground
  return color and { fg = string.format('#%06x', color) } or nil
end
```

**`utils.table.extend_keys()` (1 call site in `plugin/neogen.lua`)** -- inline loop:

```lua
-- Before:
opts.languages = utils.table.extend_keys(
  opts.languages or {},
  { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  { template = { annotation_convention = 'jsdoc' } }
)

-- After (directly in neogen.setup languages table):
javascript = { template = { annotation_convention = 'jsdoc' } },
javascriptreact = { template = { annotation_convention = 'jsdoc' } },
typescript = { template = { annotation_convention = 'jsdoc' } },
typescriptreact = { template = { annotation_convention = 'jsdoc' } },
```

**`utils.treesitter.have()` (1 call site in `plugin/nvim-treesitter.lua`)** -- local helper:

```lua
local function have_parser(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and pcall(vim.treesitter.language.inspect, lang)
end
```

**`utils.get_logger()` (1 call site in `plugin/nvim-lint.lua`)** -- removed:

The logger was only used for debug logging in the lint function. Replace with
`vim.notify()` if needed, or simply remove the logging call.

---

## Phase 6: Native LSP Configs

See directory structure above for the full list of `lsp/*.lua` files.
Each file returns a config table consumed by `vim.lsp.config()` / `vim.lsp.enable()`.

---

## Phase 7: Plugin Files

### `plugin/lsp.lua`

```lua
local icons = require('config.icons')

local function augroup(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end

-- Plugins needed for LSP ecosystem
vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/b0o/SchemaStore.nvim',
  'https://github.com/Hoffs/omnisharp-extended-lsp.nvim',
})

require('fidget').setup({})

-- Global LSP defaults (merged into every server config)
vim.lsp.config('*', {
  capabilities = {
    workspace = {
      fileOperations = { didRename = true, willRename = true },
    },
  },
  root_markers = { '.git' },
})

-- Diagnostics
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

-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('lsp_attach'),
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

    local methods = vim.lsp.protocol.Methods

    -- Document highlights
    if client:supports_method(methods.textDocument_documentHighlight, event.buf) then
      local hl_group = augroup('lsp_highlight')
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf, group = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf, group = hl_group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = augroup('lsp_detach'),
        callback = function(e)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'local_lsp_highlight', buffer = e.buf })
        end,
      })
    end

    -- Inlay hints
    if client:supports_method(methods.textDocument_inlayHint, event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    -- Per-server attach hooks
    if client.name == 'gopls' then
      if client.server_capabilities.semanticTokensProvider then return end
      local semantic = client.config.capabilities.textDocument.semanticTokens
      if not semantic then return end
      client.server_capabilities.semanticTokensProvider = {
        full = true, range = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
      }
    end

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
      map('<leader>co', function()
        vim.lsp.buf.code_action({
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
          apply = true,
        })
      end, '[o]rganize imports')
    end

    if client.name == 'omnisharp' then
      map('gd', function() require('omnisharp_extended').lsp_definitions() end, '[g]oto [d]efinition')
      map('gi', function() require('omnisharp_extended').lsp_implementation() end, '[g]oto [i]mplementation')
      map('gr', function() require('omnisharp_extended').lsp_references() end, '[g]oto [r]eferences')
      map('<leader>D', function() require('omnisharp_extended').lsp_type_definition() end, 'type definition')
    end
  end,
})

-- Enable all servers
vim.lsp.enable({
  'bashls', 'bicep', 'biome', 'buf_ls', 'copilot', 'cssls', 'cspell_ls',
  'docker_compose_language_service', 'dockerls', 'eslint', 'fish_lsp',
  'gopls', 'html', 'jsonls', 'lua_ls', 'marksman', 'omnisharp',
  'ruff', 'tailwindcss', 'taplo', 'templ', 'tinymist', 'tsgo',
  'ty', 'yamlls', 'zls',
})

vim.keymap.set('n', '<leader>il', '<cmd>checkhealth vim.lsp<cr>', { desc = '[l]sp' })
```

### `plugin/mason.lua`

```lua
vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup({
  ui = { border = vim.g.window_border },
})

local ensure_installed = {
  'csharpier', 'delve', 'dotenv-linter', 'editorconfig-checker',
  'golangci-lint', 'hadolint', 'js-debug-adapter', 'markdownlint-cli2',
  'netcoredbg', 'prettierd', 'shellcheck', 'shfmt', 'sqlfluff',
  'sqlfmt', 'stylua', 'taplo', 'templ', 'typstyle',
}

local mr = require('mason-registry')
mr:on('package:install:success', function()
  vim.defer_fn(function()
    vim.api.nvim_exec_autocmds('FileType', { buffer = vim.api.nvim_get_current_buf() })
  end, 100)
end)

mr.refresh(function()
  for _, tool in ipairs(ensure_installed) do
    local ok, p = pcall(mr.get_package, tool)
    if ok and not p:is_installed() then p:install() end
  end
end)

require('mason-lspconfig').setup({
  automatic_enable = {
    exclude = { 'rust_analyzer' },
  },
})

vim.keymap.set('n', '<leader>nm', '<cmd>Mason<cr>', { desc = '[m]ason' })
```

### `plugin/snacks.lua`

```lua
vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local exclude = { '__pycache__', '.DS_Store', 'thumbs.db' }

require('snacks').setup({
  bigfile = { enabled = true },
  explorer = {},
  indent = { enabled = true },
  notifier = { enabled = true },
  picker = {
    sources = {
      explorer = { hidden = true, ignored = true, exclude = exclude },
      files = { hidden = true, exclude = exclude },
      grep = { hidden = true, exclude = exclude },
    },
  },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = { wo = { wrap = true } },
  },
})

-- Explorer
local explore = function(dir)
  return function() Snacks.explorer({ cwd = dir }) end
end

local pick = function(type, opts)
  return function() Snacks.picker[type](opts) end
end

vim.keymap.set('n', '<leader>e', '<leader>fe', { desc = '[e]xplorer cwd', remap = true })
vim.keymap.set('n', '<leader>fe', explore(vim.uv.cwd()), { desc = '[e]xplorer cwd' })
vim.keymap.set('n', '<leader>fE', explore(vim.fs.root(0, '.git') or vim.uv.cwd()), { desc = '[e]xplorer root' })
vim.keymap.set('n', '<leader><leader>', pick('files'), { desc = 'search files' })
vim.keymap.set('n', '<leader>sb', pick('buffers'), { desc = '[b]uffers' })
vim.keymap.set('n', '<leader>sd', pick('diagnostics'), { desc = '[d]iagnostics' })
vim.keymap.set('n', '<leader>sf', pick('files'), { desc = '[f]iles' })
vim.keymap.set('n', '<leader>sg', pick('grep'), { desc = 'live [g]rep' })
vim.keymap.set('n', '<leader>sh', pick('help'), { desc = '[h]elp' })
vim.keymap.set('n', '<leader>sk', pick('keymaps'), { desc = '[k]eymaps' })
vim.keymap.set('n', '<leader>sw', pick('grep_word'), { desc = 'current [w]ord' })
```

### `plugin/conform.lua`

```lua
local format = require('util.format')

vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
  log_level = vim.log.levels.DEBUG,
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
          'format', '--option', string.format('column_width=%d', line_length),
          '--option', 'align_entries=true', '--option', 'reorder_arrays=true', '-',
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

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format({ async = true })
end, { desc = '[f]ormat buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>cF', function()
  require('conform').format({ formatters = { 'injected' } })
end, { desc = '[F]ormat injected langs' })
vim.keymap.set('n', '<leader>ic', '<cmd>ConformInfo<cr>', { desc = '[c]onform' })
```

### `plugin/nvim-treesitter.lua`

```lua
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

local function have_parser(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and pcall(vim.treesitter.language.inspect, lang)
end

local ts = require('nvim-treesitter')
ts.setup({})
ts.install({
  'bash', 'bicep', 'c_sharp', 'css', 'dockerfile', 'fish',
  'git_config', 'gitignore',
  'go', 'gomod', 'gosum', 'gotmpl', 'gowork',
  'html', 'http', 'hurl',
  'javascript', 'json', 'json5',
  'kdl', 'lua', 'luadoc', 'luap', 'make',
  'markdown', 'markdown_inline', 'mermaid',
  'ninja', 'proto', 'python',
  'query', 'regex', 'ron', 'rst', 'rust',
  'scss', 'sql', 'templ', 'toml', 'tsx', 'typescript', 'typst',
  'vim', 'vimdoc', 'yaml', 'zig',
})

vim.treesitter.language.register('bash', { 'dotenv', 'sh', 'zsh' })

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if have_parser(args.match) then pcall(vim.treesitter.start) end
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.keymap.set('n', '<leader>it', function()
  local installed = require('nvim-treesitter').get_installed('parsers')
  vim.notify_once('Installed parsers:\n\n' .. table.concat(installed, ', '))
end, { desc = '[t]reesitter' })
```

### `plugin/nvim-treesitter-textobjects.lua`

```lua
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
})

require('nvim-treesitter-textobjects').setup({})

local moves = {
  goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
  goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
  goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
  goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
}

for method, keymaps in pairs(moves) do
  for key, query in pairs(keymaps) do
    local desc = query:gsub('@', ''):gsub('%..*', '')
    desc = desc:sub(1, 1):upper() .. desc:sub(2)
    desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
    desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
    vim.keymap.set({ 'n', 'x', 'o' }, key, function()
      if vim.wo.diff and key:find('[cC]') then return vim.cmd('normal! ' .. key) end
      require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
    end, { desc = desc, silent = true })
  end
end
```

### `plugin/nvim-lint.lua`

```lua
vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

local lint = require('lint')

lint.linters_by_ft = {
  dockerfile = { 'hadolint' },
  dotenv = { 'dotenv_linter' },
  editorconfig = { 'editorconfig-checker' },
  fish = { 'fish' },
  go = { 'golangcilint' },
  markdown = { 'markdownlint-cli2' },
  proto = { 'buf_lint' },
  sql = { 'sqlfluff' },
}

-- Custom linter overrides
lint.linters.dotenv_linter = vim.tbl_deep_extend('force', lint.linters.dotenv_linter or {}, {})
lint.linters.golangcilint = vim.tbl_deep_extend('force', lint.linters.golangcilint or {}, {})
lint.linters.hadolint = vim.tbl_deep_extend('force', lint.linters.hadolint or {}, {})
lint.linters['markdownlint-cli2'] = vim.tbl_deep_extend('force', lint.linters['markdownlint-cli2'] or {}, {
  args = { '--config', vim.fn.expand('~/.config/nvim/.config/markdownlint.json') },
})
lint.linters.sqlfluff = vim.tbl_deep_extend('force', lint.linters.sqlfluff or {}, {
  args = { 'lint', '--format=json' },
})

-- Debounced lint
local function debounce(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

local function do_lint()
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  names = vim.list_extend({}, names)
  if #names == 0 then vim.list_extend(names, lint.linters_by_ft['_'] or {}) end
  vim.list_extend(names, lint.linters_by_ft['*'] or {})

  local ctx = { filename = vim.api.nvim_buf_get_name(0), filetype = vim.bo.filetype }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then vim.notify('Linter not found: ' .. name, vim.log.levels.WARN) end
    return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
  end, names)

  if #names > 0 then lint.try_lint(names) end
end

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
  callback = debounce(100, do_lint),
})

vim.api.nvim_create_user_command('NvimLintInfo', function()
  local ft = vim.bo.filetype
  local linters = lint.linters_by_ft[ft]
  vim.notify(
    linters and ('Linters for ' .. ft .. ': \n' .. table.concat(linters, '\n'))
      or ('No linters configured for file type: ' .. ft)
  )
end, { desc = 'Get information about the linters for the current buffer.' })

vim.keymap.set('n', '<leader>in', '<cmd>NvimLintInfo<cr>', { desc = '[n]vim-lint' })
```

### `plugin/neotest.lua`

```lua
vim.pack.add({
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nsidorenco/neotest-vstest',
  'https://github.com/fredrikaverpil/neotest-golang',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/marilari88/neotest-vitest',
  'https://github.com/lawrence-laz/neotest-zig',
})

local function find_config(file_name)
  return function()
    local file = vim.fn.expand('%:p')
    if string.find(file, '/packages/') then
      return string.match(file, '(.-/[^/]+/)src') .. file_name
    end
    return vim.fn.getcwd() .. '/' .. file_name
  end
end

local neotest_ns = vim.api.nvim_create_namespace('neotest')
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
    end,
  },
}, neotest_ns)

local adapters = {
  require('neotest-vstest')({ dap_settings = { type = 'netcoredbg' } }),
  require('neotest-golang')({ runner = 'gotestsum' }),
  require('neotest-python')({
    runner = 'pytest', python = './.venv/bin/python',
    args = { '--log-level', 'DEBUG' }, dap = { justMyCode = true },
  }),
  require('neotest-jest')({
    jestCommand = 'npm test --', jestConfigFile = find_config('jest.config.ts'),
  }),
  require('neotest-vitest')({ vitestConfigFile = find_config('vitest.config.ts') }),
  require('neotest-zig')({ dap = { adapters = 'lldb-dap' } }),
  require('rustaceanvim.neotest'),
}

local consumers = {}
consumers.trouble = function(client)
  client.listeners.results = function(adapter_id, results, partial)
    if partial then return end
    local tree = assert(client:get_position(nil, { adapter = adapter_id }))
    local failed = 0
    for pos_id, result in pairs(results) do
      if result.status == 'failed' and tree:get_key(pos_id) then failed = failed + 1 end
    end
    vim.schedule(function()
      local trouble = require('trouble')
      if trouble.is_open() then
        trouble.refresh()
        if failed == 0 then trouble.close() end
      end
    end)
    return {}
  end
end

require('neotest').setup({
  adapters = adapters,
  consumers = consumers,
  status = { virtual_text = true },
  output = { open_on_run = true },
  quickfix = {
    open = function() require('trouble').open({ mode = 'quickfix', focus = false }) end,
  },
})

vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run(vim.uv.cwd()) end, { desc = 'run [a]ll files' })
vim.keymap.set('n', '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, { desc = '[d]ebug nearest' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = 'run [f]ile' })
vim.keymap.set('n', '<leader>tl', function() require('neotest').run.run_last() end, { desc = 'run [l]ast' })
vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run() end, { desc = '[r]un nearest' })
vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open({ enter = true, auto_close = true })
end, { desc = 'show [o]utput' })
vim.keymap.set('n', '<leader>tO', function() require('neotest').output_panel.toggle() end, { desc = '[O]utput panel' })
vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = '[s]ummary' })
vim.keymap.set('n', '<leader>tS', function() require('neotest').run.stop() end, { desc = '[S]top' })
vim.keymap.set('n', '<leader>tw', function()
  require('neotest').watch.toggle(vim.fn.expand('%'))
end, { desc = '[w]atch' })
```

### `plugin/nvim-dap.lua`

```lua
local icons = require('config.icons')
local pkg = require('util.pkg')

vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mfussenegger/nvim-dap-python',
})

local dap = require('dap')
local dapui = require('dapui')

require('nvim-dap-virtual-text').setup({})
require('mason-nvim-dap').setup({ automatic_installation = true, handlers = {}, ensure_installed = {} })
require('dap-python').setup(pkg.get_path('debugpy', '/venv/bin/python'))

-- DAP signs
vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
for name, sign in pairs(icons.dap) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define('Dap' .. name, {
    text = sign[1], texthl = sign[2] or 'DiagnosticInfo',
    linehl = sign[3], numhl = sign[3],
  })
end

-- VSCode launch.json
local vscode = require('dap.ext.vscode')
local json = require('plenary.json')
vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end

-- C# / .NET
if not dap.adapters['netcoredbg'] then
  dap.adapters['netcoredbg'] = {
    type = 'executable', command = vim.fn.exepath('netcoredbg'), args = { '--interpreter=vscode' },
  }
end
for _, lang in ipairs({ 'cs', 'fsharp', 'vb' }) do
  if not dap.configurations[lang] then
    dap.configurations[lang] = {{
      type = 'netcoredbg', name = 'Launch file', request = 'launch',
      program = function() return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file') end,
      cwd = '${workspaceFolder}',
    }}
  end
end

-- Go
vscode.type_to_filetypes['delve'] = { 'go' }
vscode.type_to_filetypes['go'] = { 'go' }

-- Python
vscode.type_to_filetypes['python'] = { 'python' }

-- JavaScript / TypeScript
if not dap.adapters['pwa-node'] then
  dap.adapters['pwa-node'] = {
    type = 'server', host = 'localhost', port = '${port}',
    executable = {
      command = 'node',
      args = {
        pkg.get_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
        '${port}',
      },
    },
  }
end
if not dap.adapters['node'] then
  dap.adapters['node'] = function(cb, cfg)
    if cfg.type == 'node' then cfg.type = 'pwa-node' end
    local native = dap.adapters['pwa-node']
    if type(native) == 'function' then native(cb, cfg) else cb(native) end
  end
end
local js_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
vscode.type_to_filetypes['node'] = js_filetypes
vscode.type_to_filetypes['pwa-node'] = js_filetypes
for _, lang in ipairs(js_filetypes) do
  dap.configurations[lang] = {
    {
      name = 'Launch File', type = 'pwa-node', request = 'launch',
      program = '${file}', cwd = '${workspaceFolder}', console = 'integratedTerminal',
    },
    {
      name = 'Attach to Process', type = 'pwa-node', request = 'attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}', console = 'integratedTerminal',
    },
  }
end

-- DAP UI
dapui.setup({
  layouts = {
    {
      elements = {
        { id = 'breakpoints', size = 0.2 },
        { id = 'scopes', size = 0.4 },
        { id = 'stacks', size = 0.4 },
      },
      position = 'left', size = 40,
    },
    {
      elements = {
        { id = 'repl', size = 0.5 },
        { id = 'console', size = 0.5 },
      },
      position = 'bottom', size = 15,
    },
  },
})
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end

-- Keymaps
local function get_args(cfg)
  local args = type(cfg.args) == 'function' and (cfg.args() or {}) or cfg.args or {}
  cfg = vim.deepcopy(cfg)
  cfg.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' '))
    return vim.split(vim.fn.expand(new_args), ' ')
  end
  return cfg
end

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = '[F5] continue' })
vim.keymap.set('n', '<F9>', function() dap.step_out() end, { desc = '[F9] step out' })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = '[F10] step over' })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = '[F11] step into' })
vim.keymap.set('n', '<F12>', function() dap.step_over() end, { desc = '[F12] terminate' })
vim.keymap.set('n', '<leader>da', function() dap.continue({ before = get_args }) end, { desc = 'run with [a]rgs' })
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'toggle [b]reakpoint' })
vim.keymap.set('n', '<leader>dB', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'conditional [B]reakpoint' })
vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = '[c]ontinue' })
vim.keymap.set('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'run to [C]ursor' })
vim.keymap.set('n', '<leader>dg', function() dap.goto_() end, { desc = '[g]oto line' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'step [i]nto' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'run [l]ast' })
vim.keymap.set('n', '<leader>do', function() dap.step_out() end, { desc = 'step [o]ut' })
vim.keymap.set('n', '<leader>dO', function() dap.step_over() end, { desc = 'step [O]ver' })
vim.keymap.set('n', '<leader>dp', function() dap.pause() end, { desc = '[p]ause' })
vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'toggle [r]EPL' })
vim.keymap.set('n', '<leader>ds', function() dap.session() end, { desc = '[s]ession' })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = '[t]erminate' })
vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = '[w]idgets' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, { desc = '[e]val' })
vim.keymap.set('n', '<leader>du', function() dapui.toggle({}) end, { desc = '[u]i' })
```

### `plugin/neogen.lua`

```lua
vim.pack.add({ 'https://github.com/danymat/neogen' })

require('neogen').setup({
  languages = {
    sh = { template = { annotation_convention = 'google_bash' } },
    cs = { template = { annotation_convention = 'xmldoc' } },
    go = { template = { annotation_convention = 'godoc' } },
    lua = { template = { annotation_convention = 'emmylua' } },
    python = { template = { annotation_convention = 'google_docstrings' } },
    rust = { template = { annotation_convention = 'rustdoc' } },
    javascript = { template = { annotation_convention = 'jsdoc' } },
    javascriptreact = { template = { annotation_convention = 'jsdoc' } },
    typescript = { template = { annotation_convention = 'jsdoc' } },
    typescriptreact = { template = { annotation_convention = 'jsdoc' } },
  },
})

vim.keymap.set('n', '<leader>cD', function()
  require('neogen').generate({ type = 'any', snippet_engine = 'nvim' })
end, { desc = 'generate [d]ocs' })
```

### `plugin/mini-icons.lua`

```lua
vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })

require('mini.icons').setup({
  directory = {
    notebooks = { glyph = '???', hl = 'MiniIconsBlue' },
  },
  extension = {
    bash = { glyph = '???', hl = 'MiniIconsGrey' },
    ['bash.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['code-workspace'] = { glyph = '???', hl = 'MiniIconsBlue' },
    fish = { glyph = '???', hl = 'MiniIconsGrey' },
    ['fish.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['json.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    kdl = { glyph = '???', hl = 'MiniIconsYellow' },
    ['kdl.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['ps1.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['sh.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['toml.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['yaml.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
    zsh = { glyph = '???', hl = 'MiniIconsGrey' },
    ['zsh.tmpl'] = { glyph = '???', hl = 'MiniIconsGrey' },
  },
  file = {
    ['.chezmoiroot'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['.chezmoiversion'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['.dockerignore'] = { glyph = '???', hl = 'MiniIconsBlue' },
    ['.eslintrc.js'] = { glyph = '???', hl = 'MiniIconsPurple' },
    ['.go-version'] = { glyph = '???', hl = 'MiniIconsAzure' },
    ['.keep'] = { glyph = '???', hl = 'MiniIconsGrey' },
    ['.node-version'] = { glyph = '???', hl = 'MiniIconsGreen' },
    ['.prettierrc'] = { glyph = '???', hl = 'MiniIconsPurple' },
    ['.python-version'] = { glyph = '???', hl = 'MiniIconsYellow' },
    ['.yarnrc.yml'] = { glyph = '???', hl = 'MiniIconsBlue' },
    ['devcontainer.json'] = { glyph = '???', hl = 'MiniIconsAzure' },
    ['eslint.config.js'] = { glyph = '???', hl = 'MiniIconsPurple' },
    ['package.json'] = { glyph = '???', hl = 'MiniIconsGreen' },
    ['tsconfig.json'] = { glyph = '???', hl = 'MiniIconsAzure' },
    ['tsconfig.build.json'] = { glyph = '???', hl = 'MiniIconsAzure' },
    ['yarn.lock'] = { glyph = '???', hl = 'MiniIconsBlue' },
  },
  filetype = {
    curl = { glyph = '???', hl = 'MiniIconsRed' },
    dotenv = { glyph = '???', hl = 'MiniIconsYellow' },
    gotmpl = { glyph = '???', hl = 'MiniIconsGrey' },
    http = { glyph = '???', hl = 'MiniIconsRed' },
    ['yaml.docker-compose'] = { hl = 'MiniIconsAzure' },
  },
})

-- Mock nvim-web-devicons for plugins that expect it
package.preload['nvim-web-devicons'] = function()
  require('mini.icons').mock_nvim_web_devicons()
  return package.loaded['nvim-web-devicons']
end
```

Note: icon glyphs will need to be copied from the original source files to preserve
the actual Unicode characters.

### `plugin/blink.lua`

```lua
vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.compat',
  'https://github.com/fang2hou/blink-copilot',
})

require('blink.compat').setup({})

require('blink.cmp').setup({
  completion = {
    list = { selection = { preselect = true, auto_insert = false } },
    menu = { border = 'rounded', draw = { treesitter = { 'lsp' } } },
    documentation = {
      auto_show = true, auto_show_delay_ms = 200,
      window = { border = 'rounded' },
    },
    ghost_text = { enabled = true },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev' },
    providers = {
      markdown = {
        name = 'RenderMarkdown', module = 'render-markdown.integ.blink',
        fallbacks = { 'lsp' },
      },
      copilot = { name = 'copilot', module = 'blink-copilot', async = true },
      lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  signature = { enabled = true },
  keymap = {
    preset = 'default',
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
  },
})
```

### `plugin/dressing.lua`

```lua
vim.pack.add({ 'https://github.com/stevearc/dressing.nvim' })

-- Lazy-load dressing on first use of vim.ui.select/input
local dressing_loaded = false
local function ensure_dressing()
  if not dressing_loaded then
    dressing_loaded = true
    require('dressing').setup({})
  end
end

vim.ui.select = function(...)
  ensure_dressing()
  return vim.ui.select(...)
end
vim.ui.input = function(...)
  ensure_dressing()
  return vim.ui.input(...)
end
```

### `plugin/lualine.lua`

```lua
local icons = require('config.icons')

vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local function fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local color = hl.fg or hl.foreground
  return color and { fg = string.format('#%06x', color) } or nil
end

vim.g.lualine_laststatus = vim.o.laststatus
if vim.fn.argc(-1) > 0 then
  vim.o.statusline = ' '
else
  vim.o.laststatus = 0
end

vim.o.laststatus = vim.g.lualine_laststatus

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter' } },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'diagnostics',
        symbols = {
          error = icons.diagnostics.Error, warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info, hint = icons.diagnostics.Hint,
        },
      },
      {
        'filetype', icon_only = true, separator = '',
        padding = { left = 1, right = 0 },
      },
    },
    lualine_x = {
      {
        function() return require('noice').api.status.command.get() end,
        cond = function()
          return package.loaded['noice'] and require('noice').api.status.command.has()
        end,
        color = function() return fg('Statement') end,
      },
      {
        function() return require('noice').api.status.mode.get() end,
        cond = function()
          return package.loaded['noice'] and require('noice').api.status.mode.has()
        end,
        color = function() return fg('Constant') end,
      },
      {
        function() return '  ' .. require('dap').status() end,
        cond = function()
          return package.loaded['dap'] and require('dap').status() ~= ''
        end,
        color = function() return fg('Debug') end,
      },
      {
        'diff',
        symbols = {
          added = icons.git.added, modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added, modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
    },
    lualine_y = {
      { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
      { 'location', padding = { left = 0, right = 1 } },
    },
    lualine_z = { function() return ' ' .. os.date('%R') end },
  },
  extensions = { 'neo-tree' },
})
```

Note: The `require('lazy.status').updates` component and `'lazy'` extension are removed.

### `plugin/mini-starter.lua`

```lua
vim.pack.add({
  'https://github.com/nvim-mini/mini.starter',
  'https://github.com/MaximilianLloyd/ascii.nvim',
})

local starter = require('mini.starter')
local logo = table.concat(require('ascii').get_random('text', 'neovim'), '\n')
local pad = string.rep(' ', 22)
local new_section = function(name, action, section)
  return { name = name, action = action, section = pad .. section }
end

starter.setup({
  evaluate_single = true,
  header = logo,
  items = {
    new_section('New file', 'ene | startinsert', 'Built-in'),
    new_section('Quit Neovim', 'qall', 'Built-in'),
    new_section('Restore session', [[lua require("persistence").load()]], 'Session'),
    new_section('Mason', 'Mason', 'Config'),
    new_section('Find files', [[lua require("snacks").picker.files()]], 'Search'),
    new_section('Live grep', [[lua require("snacks").picker.grep()]], 'Search'),
    new_section('Recent files', [[lua require("snacks").picker.recent()]], 'Search'),
    new_section('Command history', [[lua require("snacks").picker.command_history()]], 'Search'),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(pad .. '??? ', false),
    starter.gen_hook.aligning('center', 'center'),
  },
})
```

Note: The `lazy.nvim` starter section, `LazyVimStarted` autocmd, and startup stats footer
are removed.

### Remaining `plugin/` Files (Straightforward Translations)

These all follow the same pattern: `vim.pack.add()` + `require().setup()` + `vim.keymap.set()`:

| File                                 | Plugins                 | Notes                                            |
| ------------------------------------ | ----------------------- | ------------------------------------------------ |
| `plugin/flash.lua`                   | flash.nvim              | keymaps inline                                   |
| `plugin/gitsigns.lua`                | gitsigns.nvim           | `on_attach` stays in `setup()` opts              |
| `plugin/grug-far.lua`                | grug-far.nvim           | keymaps inline                                   |
| `plugin/todo-comments.lua`           | todo-comments.nvim      | keymaps inline                                   |
| `plugin/trouble.lua`                 | trouble.nvim            | keymaps inline                                   |
| `plugin/which-key.lua`               | which-key.nvim          | full spec inline                                 |
| `plugin/bufferline.lua`              | bufferline.nvim         | keymaps inline, references `Snacks` global       |
| `plugin/edgy.lua`                    | edgy.nvim               | opts function stays                              |
| `plugin/noice.lua`                   | noice.nvim, nui.nvim    | keymaps inline                                   |
| `plugin/mini-ai.lua`                 | mini.ai                 | opts function stays (needs `require('mini.ai')`) |
| `plugin/mini-pairs.lua`              | mini.pairs              | custom `open` override stays                     |
| `plugin/mini-surround.lua`           | mini.surround           | keymaps inline                                   |
| `plugin/mini-indentscope.lua`        | mini.indentscope        | init autocmd stays                               |
| `plugin/nvim-treesitter-context.lua` | nvim-treesitter-context | simple setup                                     |
| `plugin/virt-column.lua`             | virt-column.nvim        | simple setup                                     |
| `plugin/yanky.lua`                   | yanky.nvim              | keymaps inline                                   |
| `plugin/ts-comments.lua`             | ts-comments.nvim        | `setup({})`                                      |
| `plugin/vim-sleuth.lua`              | vim-sleuth              | `vim.pack.add()` only, no setup                  |
| `plugin/persistence.lua`             | persistence.nvim        | keymaps inline                                   |
| `plugin/opencode.lua`                | opencode.nvim           | keymaps inline                                   |
| `plugin/hurl.lua`                    | hurl.nvim, nui.nvim     | keymaps inline                                   |
| `plugin/kulala.lua`                  | kulala.nvim             | keymaps inline                                   |
| `plugin/diffview.lua`                | diffview.nvim           | simple setup                                     |
| `plugin/render-markdown.lua`         | render-markdown.nvim    | simple setup                                     |
| `plugin/vivify.lua`                  | vivify.vim              | keymap + `vim.g` config                          |
| `plugin/typst-preview.lua`           | typst-preview.nvim      | keymaps inline                                   |
| `plugin/venv-selector.lua`           | venv-selector.nvim      | keymaps inline                                   |
| `plugin/rustaceanvim.lua`            | rustaceanvim            | `vim.g.rustaceanvim = ...` pattern unchanged     |
| `plugin/crates.lua`                  | crates.nvim             | simple setup                                     |
| `plugin/lazydev.lua`                 | lazydev.nvim            | simple setup                                     |
| `plugin/plenary.lua`                 | plenary.nvim            | `vim.pack.add()` only                            |

---

## Phase 8: Config File Edits

### `config/keymaps.lua`

- Replace `utils.root()` with `vim.fs.root(0, '.git') or vim.uv.cwd()`
- Change `<leader>nl` from `:Lazy` to `:PackStatus` (or remove)
- Add `<leader>nu` mapped to `:PackUpdate` for quick plugin updates
- `Snacks.bufdelete()`, `Snacks.lazygit()` -- unchanged, `Snacks` is a global set by snacks.nvim

### `config/commands.lua` (New)

- See Phase 3b for full contents
- Contains all `:Pack*` user commands for plugin management

### `config/autocmds.lua`

- Add `local function augroup(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end` at top
- Replace all `utils.autocmd.group(...)` calls with `augroup(...)`
- Rename `vim.b[buf].lazyvim_last_loc` to `vim.b[buf].last_loc`
- Add `PackChanged` hook (see Phase 3)

### `config/options.lua`

- `vim.o.statuscolumn` references `snacks.statuscolumn` -- works because snacks loads in `plugin/`
  before statuscolumn is evaluated
- `vim.o.formatexpr` references `conform` -- works because conform is loaded when formatting triggers
- Consider removing `vim.deprecate = function() end` if no longer needed

---

## Phase 9: Translation Reference

| lazy.nvim Pattern                    | vim.pack Equivalent                                                                 |
| ------------------------------------ | ----------------------------------------------------------------------------------- |
| `opts = { ... }`                     | `require('plugin').setup({ ... })`                                                  |
| `config = function(_, opts) ... end` | Inline in `plugin/*.lua` file                                                       |
| `init = function() ... end`          | Put the code before `require('plugin').setup()`                                     |
| `event = 'VeryLazy'`                 | `vim.schedule(function() ... end)` or just load eagerly                             |
| `event = 'InsertEnter'`              | `vim.api.nvim_create_autocmd('InsertEnter', { once = true, ... })`                  |
| `ft = 'python'`                      | `vim.api.nvim_create_autocmd('FileType', { pattern = 'python', once = true, ... })` |
| `cmd = 'Mason'`                      | Load eagerly or wrap in `vim.api.nvim_create_user_command`                          |
| `keys = { ... }`                     | `vim.keymap.set(...)` directly in the file                                          |
| `build = ':TSUpdate'`                | `PackChanged` autocmd in `config/autocmds.lua`                                      |
| `dependencies = { ... }`             | List dependency in same `vim.pack.add()` call                                       |
| `lazy = true` + init loading trick   | Load eagerly, or rewrite wrapper (see dressing)                                     |
| `opts_extend`                        | Not needed -- everything is in one place now                                        |
| `version = '*'`                      | `version = vim.version.range('*')`                                                  |
| `version = '^6'`                     | `version = vim.version.range('6.x')`                                                |
| `branch = 'main'`                    | `version = 'main'`                                                                  |
| `require('lazy.status').updates`     | Remove (no vim.pack equivalent)                                                     |

---

## Phase 10: Migration Process

```bash
# 1. Create isolated config copy
cp -r ~/.config/nvim ~/.config/nvim-vimpack

# 2. Work on migration without affecting current setup
NVIM_APPNAME=nvim-vimpack nvim

# 3. When satisfied, swap
mv ~/.config/nvim ~/.config/nvim-lazy-backup
mv ~/.config/nvim-vimpack ~/.config/nvim
```

---

## Risk Assessment

| Risk                         | Severity | Mitigation                                                  |
| ---------------------------- | -------- | ----------------------------------------------------------- |
| `vim.pack` is experimental   | Medium   | Pin to Neovim stable release; lockfile in git               |
| Startup time regression      | Low      | `vim.loader.enable()` compensates for eager loading         |
| Build steps forgotten        | Low      | `PackChanged` hooks in `config/autocmds.lua`                |
| Ordering bugs in `plugin/`   | Low      | Only colorscheme needs early loading, handled in `init.lua` |
| Missing plugin on first boot | Low      | All `vim.pack.add()` calls run during startup               |
