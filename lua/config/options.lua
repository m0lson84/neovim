--[[
Core Neovim options
--]]

-- [[ Global ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.node_host_prog = vim.fn.expand('~/.local/share/mise/installs/node/lts/bin/neovim-node-host')
vim.g.python3_host_prog = vim.fn.expand('~/.local/share/mise/installs/python/latest/bin/python')

-- [[ Editor ]]

vim.o.autowrite = true
vim.o.breakindent = true
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.confirm = true
vim.o.expandtab = true
vim.o.exrc = true
vim.o.formatoptions = 'jcroqlnt'
vim.o.jumpoptions = 'view'
vim.o.mouse = 'a'
vim.o.sessionoptions = 'buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds'
vim.o.shell = (vim.fn.executable('fish') and 'fish') or vim.env.SHELL or 'sh'
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.spelllang = 'en'
vim.o.tabstop = 2
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200
vim.o.virtualedit = 'block'
vim.o.wildmode = 'longest:full,full'
vim.opt.shortmess:append('WcC')
vim.opt.spelloptions:append('noplainbuffer')
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- [[ Search ]]

vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.smartcase = true

-- [[ UI ]]

vim.o.cmdheight = 0
vim.o.conceallevel = 2
vim.o.cursorline = true
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.pumblend = 10
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.wrap = false
vim.opt.fillchars = { diff = '╱', eob = ' ' }
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- [[ Windows ]]

vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true
vim.o.winminwidth = 5

-- [[ File types ]]

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
  },
  pattern = {
    ['.*%.env%..*'] = { 'dotenv', { priority = 10 } },
    ['compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['docker-compose.*%.ya?ml'] = 'yaml.docker-compose',
    ['.*/.devcontainer/.*%.json'] = 'jsonc',
    ['.*/.vscode/.*%.json'] = 'jsonc',
  },
})
