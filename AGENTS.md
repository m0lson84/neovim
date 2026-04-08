# AGENTS.md

Neovim configuration repo (Lua). Package manager: **vim.pack** (native). Requires Neovim **0.12+**.

## Repo layout

```
init.lua              -- entrypoint: startup time, vim.loader, requires config/*
lua/config/           -- options, commands, keymaps, icons, colorscheme
lua/util/             -- autocmd.lua, format.lua (conform helper), pkg.lua (mason path helper)
lsp/                  -- native vim.lsp.Config files, one per server (26 servers)
plugin/               -- auto-sourced plugin configs, one per plugin (vim.pack.add + setup + keymaps)
nvim-pack-lock.json   -- lockfile for vim.pack (pinned plugin revisions); committed
```

No `lua/plugins/` directory -- that was the old lazy.nvim layout. All plugin config lives in `plugin/`.

## Plugin file pattern

Every `plugin/<name>.lua` follows this structure, in this order:

```lua
--[[ description (https://github.com/org/repo) --]]

local icons = require('config.icons')             -- 1. Imports (config/util modules only)

vim.pack.add({ 'https://github.com/org/repo' })   -- 2. vim.pack.add

vim.o.formatexpr = '...'                           -- 3. Static config (vim options that depend on the plugin)

local function helper() ... end                    -- 4. Helpers (local functions, data tables)

require('plugin').setup({ ... })                   -- 5. Setup (require().setup() or vim.g config)

vim.api.nvim_create_autocmd(...)                   -- 6. Autocmds

vim.keymap.set(...)                                -- 7. Keymaps
```

Sections are only present when needed. Omit empty sections entirely.

- **Imports** come before `vim.pack.add()` and are limited to config/util modules (`require('config.*')`, `require('util.*')`). Plugin imports (`require('bufferline')`) come after `vim.pack.add()`.
- **`vim.pack.add()`** uses a table: `{ 'url' }` for single plugins, `{ 'url1', 'url2' }` for multiple, `{ src = 'url', version = 'v1' }` for pinned versions.
- `vim.pack.add()` defaults `load = false` during `init.lua` sourcing and `load = true` in `plugin/` files. Any `vim.pack.add()` called from a `require()`'d config module (e.g. `config.colorscheme`) must pass `{ load = true }`.
- **Keymaps** are sorted alphabetically by LHS (left-hand side) within each plugin file.
- Build hooks for treesitter, mason, and blink.cmp run via `PackChanged` autocmd in `lua/config/commands.lua`.

## Config file structure

`lua/config/` files contain **only native Neovim configuration** -- no plugin dependencies. Any option, autocmd, or keymap that depends on a plugin belongs in that plugin's `plugin/*.lua` file.

`lua/config/commands.lua` contains both auto commands and user commands, in that order:

```lua
-- [[ Auto commands ]]
vim.api.nvim_create_autocmd(...)

-- [[ User commands ]]
vim.api.nvim_create_user_command(...)
```

`lua/config/keymaps.lua` contains all global keymaps (plugin-specific keymaps live in their `plugin/*.lua` files).

## LSP setup

LSP uses **native `lsp/*.lua` files** with **nvim-lspconfig** providing default `cmd`, `filetypes`, and `root_markers` for each server. Each `lsp/<server>.lua` returns a `vim.lsp.Config` table that overrides/extends those defaults (typically just `settings`). `rust_analyzer` is handled by `rustaceanvim` and is not listed in `vim.lsp.enable()`.

Mason auto-installs servers (`mason-lspconfig` has `automatic_enable = false`; servers are explicitly enabled via `vim.lsp.enable()` in `plugin/lsp.lua`). To add a new LSP server, create `lsp/<server>.lua` and add the server name to the `vim.lsp.enable()` list in `plugin/lsp.lua`.

## Style & formatting

- **Formatter**: `stylua .` from repo root (config in `.stylua.toml`)
  - 2-space indent, 120 column width, single quotes, `collapse_simple_statement = "Always"`, sort requires
- **EditorConfig**: 2-space indent, LF, max 120 columns (100 for Lua/shell)
- **Spell check**: cspell with custom dictionary at `.config/nvim.txt`

## Conventions

- Leader `<Space>`, local leader `\`
- Plugin files use `--[[ description --]]` block comments at the top
- Module pattern: `local M = {}` ... `return M` (for `lua/util/` files)
- No globals -- use explicit `require('config.icons')`, `require('util.format')`, etc.
- Provider config: node and python via mise; ruby and perl providers disabled

## Adding a new plugin

1. Create `plugin/<name>.lua` with `vim.pack.add()`, setup, and keymaps
2. If it needs mason, add to `ensure_installed` in `plugin/mason.lua`

## Adding a new language

1. Add treesitter parser to `ensure_installed` in `plugin/nvim-treesitter.lua`
2. Create `lsp/<server>.lua` for the language server
3. Add formatter mapping in `plugin/conform.lua` (`formatters_by_ft`)
4. Add linter mapping in `plugin/nvim-lint.lua` (`linters_by_ft`) if needed
5. Add mason packages to `plugin/mason.lua` `ensure_installed`

## Gotchas

- Files > 1.5 MB auto-detect as `bigfile` filetype, disabling LSP/treesitter
- Custom filetypes in `lua/config/options.lua`: `.env*` -> `dotenv`, `.http`/`.rest` -> `http`, `.tmpl` -> `gotmpl`, docker-compose -> `yaml.docker-compose`, `.code-workspace` / devcontainer JSON / `.vscode/*.json` -> `jsonc`
- `nvim-pack-lock.json` is committed -- do not delete it
- `scripts/install.sh` builds Neovim from source on Linux; not relevant for config changes
