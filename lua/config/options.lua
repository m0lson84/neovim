--[[
Core Neovim Options
--]]

--[[ Helper Functions ]]

--- Append a value to a comma-separated list, if it's not already present.
---@param current string The current list value
---@param value string The value to append
---@return string result  The new list value
local function append(current, value)
  local pattern = '(^|,)' .. vim.pesc(value) .. '(,|$)'
  if current:match(pattern) then return current end
  return current == '' and value or (current .. ',' .. value)
end

--- Convert a dictionary to a string of vim options.
---@param dict table The dictionary to convert.
---@return string result The vim options string.
local function dict_to_vimopt(dict)
  local parts = {}
  for k, v in pairs(dict) do
    table.insert(parts, k .. ':' .. v)
  end
  return table.concat(parts, ',')
end

-- Hide deprecation warnings
-- TODO: Remove this when deprecations are fixed
vim.deprecate = function() end

--[[ Global variables ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.node_host_prog = vim.fn.expand('~/.local/share/mise/installs/node/lts/bin/neovim-node-host')
vim.g.python3_host_prog = vim.fn.expand('~/.local/share/mise/installs/python/3.13/bin/python')

-- UI
vim.g.window_border = 'rounded'

--[[ Local options ]]

-- Use system clipboard
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Default shell
vim.o.shell = (vim.fn.executable('fish') and 'fish') or vim.env.SHELL or 'sh'

-- Relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.o.listchars = dict_to_vimopt({ tab = '» ', trail = '·', nbsp = '␣' })

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Enable auto write
vim.o.autowrite = true

vim.o.completeopt = 'menu,menuone,noselect'

-- Hide * markup for bold and italic, but not markers with substitutions
vim.o.conceallevel = 2

-- Confirm to save changes before exiting modified buffer
vim.o.confirm = true

-- Enable highlighting of the current line
vim.o.cursorline = true

-- Use spaces instead of tabs
vim.o.expandtab = true

vim.o.fillchars = dict_to_vimopt({
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
})

vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.ignorecase = true -- Ignore case
vim.o.inccommand = 'nosplit' -- preview incremental substitute
vim.o.jumpoptions = 'view'
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- Wrap lines at convenient points
vim.o.list = true -- Show some invisible characters (tabs...
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.number = true -- Print line number
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.relativenumber = true -- Relative line numbers
vim.o.scrolloff = 4 -- Lines of context
vim.o.sessionoptions = 'buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds'

vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent

vim.o.shortmess = vim.o.shortmess .. 'WIcC'
vim.o.showmode = false -- Dont show mode since we have a statusline

vim.o.sidescrolloff = 8 -- Columns of context
vim.o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time

vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.smartindent = true -- Insert indents automatically

vim.o.spelllang = 'en'
vim.o.spelloptions = append(vim.o.spelloptions, 'noplainbuffer')

vim.o.splitbelow = true -- Put new windows below current
vim.o.splitkeep = 'screen'
vim.o.splitright = true -- Put new windows right of current

vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- Number of spaces tabs count for
vim.o.tabstop = 2

-- True color support
vim.o.termguicolors = true

-- Lower than default (1000) to quickly trigger which-key
vim.o.timeoutlen = vim.g.vscode and 1000 or 300

vim.o.undofile = true
vim.o.undolevels = 10000

-- Save swap file and trigger CursorHold
vim.o.updatetime = 200

-- Allow cursor to move where there is no text in visual block mode
vim.o.virtualedit = 'block'

-- Command-line completion mode
vim.o.wildmode = 'longest:full,full'

-- Minimum window width
vim.o.winminwidth = 5

-- Disable line wrap
vim.o.wrap = false

-- Code folding options
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Formatter options
vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
vim.o.formatoptions = 'jcroqlnt'

--[[ File types ]]

vim.filetype.add({
  extension = {
    ['code-workspace'] = 'jsonc',
    conf = 'conf',
    env = 'dotenv',
    http = 'http',
    rest = 'http',
    tmpl = 'gotmpl',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['devcontainer.json'] = 'jsonc',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'dotenv',
    ['compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['docker-compose.*%.ya?ml'] = 'yaml.docker-compose',
  },
})

--[[ Zellij ]]

if vim.env.ZELLIJ ~= nil then vim.fn.system({ 'zellij', 'action', 'switch-mode', 'locked' }) end
