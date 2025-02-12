--[[
Core Neovim Options
--]]

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

local opt = vim.opt

-- Use system clipboard
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

opt.number = true
opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Enable auto write
opt.autowrite = true

opt.completeopt = 'menu,menuone,noselect'

-- Hide * markup for bold and italic, but not markers with substitutions
opt.conceallevel = 2

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Enable highlighting of the current line
opt.cursorline = true

-- Use spaces instead of tabs
opt.expandtab = true

opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.jumpoptions = 'view'
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent

opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline

opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time

opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically

opt.spelllang = { 'en' }
opt.spelloptions:append('noplainbuffer')

opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current

opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- Number of spaces tabs count for
opt.tabstop = 2

-- True color support
opt.termguicolors = true

-- Lower than default (1000) to quickly trigger which-key
opt.timeoutlen = vim.g.vscode and 1000 or 300

opt.undofile = true
opt.undolevels = 10000

-- Save swap file and trigger CursorHold
opt.updatetime = 200

-- Allow cursor to move where there is no text in visual block mode
opt.virtualedit = 'block'

-- Command-line completion mode
opt.wildmode = 'longest:full,full'

-- Minimum window width
opt.winminwidth = 5

-- Disable line wrap
opt.wrap = false

-- Code folding options
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Formatter options
opt.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
opt.formatoptions = 'jcroqlnt'

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
