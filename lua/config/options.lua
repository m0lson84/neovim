--[[
Core Neovim Options
--]]

-- [[ Global variables ]]

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.node_host_prog = vim.fn.expand('~/.local/share/mise/installs/node/lts/bin/neovim-node-host')
vim.g.python3_host_prog = vim.fn.expand('~/.local/share/mise/installs/python/latest/bin/python')

-- [[ Local options ]]

-- Use system clipboard
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Default shell
vim.o.shell = (vim.fn.executable('fish') and 'fish') or vim.env.SHELL or 'sh'

vim.o.autowrite = true -- Enable auto write
vim.o.breakindent = true -- Enable break indent
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Highlight current line
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.ignorecase = true -- Ignore case
vim.o.inccommand = 'nosplit' -- Preview incremental substitute
vim.o.jumpoptions = 'view'
vim.o.laststatus = 3 -- Global statusline
vim.o.linebreak = true -- Wrap lines at convenient points
vim.o.list = true -- Show some invisible characters (tabs...)
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.number = true -- Print line number
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.relativenumber = true -- Relative line numbers
vim.o.scrolloff = 4 -- Lines of context
vim.o.sessionoptions = 'buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds'
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.cmdheight = 0 -- Hide cmdline when not in use
vim.o.showmode = false -- Don't show mode since we have a statusline
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.signcolumn = 'yes' -- Always show the signcolumn
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.smartindent = true -- Insert indents automatically
vim.o.spelllang = 'en'
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitkeep = 'screen'
vim.o.splitright = true -- Put new windows right of current
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.timeoutlen = 300 -- Lower than default to quickly trigger which-key
vim.o.undofile = true -- Save undo history
vim.o.undolevels = 10000
vim.o.updatetime = 200 -- Save swap file and trigger CursorHold
vim.o.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.o.wildmode = 'longest:full,full' -- Command-line completion mode
vim.o.winminwidth = 5 -- Minimum window width
vim.o.wrap = false -- Disable line wrap

vim.opt.shortmess:append('WcC')
vim.opt.spelloptions:append('noplainbuffer')
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = {
  diff = '╱',
  eob = ' ',
}

-- Formatter
vim.o.formatoptions = 'jcroqlnt'

-- [[ File types ]]

vim.filetype.add({
  extension = {
    ['code-workspace'] = 'jsonc',
    conf = 'conf',
    http = 'http',
    rest = 'http',
    tmpl = 'gotmpl',
  },
  pattern = {
    ['.*%.?env%.?.*'] = 'dotenv',
    ['compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['docker-compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['.*/.devcontainer/.*%.json'] = 'jsonc',
    ['.*/.vscode/.*%.json'] = 'jsonc',
  },
})
