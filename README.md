# neovim

<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/plugin-manager?style=for-the-badge" /></a>

## Requirements

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)

## Install Instructions

> Install requires Neovim 0.10+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone https://github.com/m0lson84/neovim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=m0lson84/neovim/ nvim
```

## Plugins

### bars-and-lines

- [lukas-reineke/virt-column.nvim](https://dotfyle.com/plugins/lukas-reineke/virt-column.nvim)

### code-runner

- [Vigemus/iron.nvim](https://dotfyle.com/plugins/Vigemus/iron.nvim)
- [benlubas/molten-nvim](https://dotfyle.com/plugins/benlubas/molten-nvim)

### colorscheme

- [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)

### comment

- [folke/ts-comments.nvim](https://dotfyle.com/plugins/folke/ts-comments.nvim)
- [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
- [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)

### completion

- [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
- [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)

### debugging

- [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
- [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)

### dependency-management

- [Saecki/crates.nvim](https://dotfyle.com/plugins/Saecki/crates.nvim)

### diagnostics

- [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)

### editing-support

- [echasnovski/mini.ai](https://dotfyle.com/plugins/echasnovski/mini.ai)
- [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
- [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim)
- [echasnovski/mini.pairs](https://dotfyle.com/plugins/echasnovski/mini.pairs)
- [gbprod/yanky.nvim](https://dotfyle.com/plugins/gbprod/yanky.nvim)

### file-explorer

- [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)
- [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)

### formatting

- [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### fuzzy-finder

- [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)
- [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)

### git

- [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
- [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)

### icon

- [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
- [echasnovski/mini.icons](https://dotfyle.com/plugins/echasnovski/mini.icons)

### indent

- [echasnovski/mini.indentscope](https://dotfyle.com/plugins/echasnovski/mini.indentscope)
- [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)

### keybinding

- [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)

### lsp

- [mrcjkb/rustaceanvim](https://dotfyle.com/plugins/mrcjkb/rustaceanvim)
- [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
- [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
- [b0o/SchemaStore.nvim](https://dotfyle.com/plugins/b0o/SchemaStore.nvim)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)

### lsp-installer

- [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### markdown-and-latex

- [MeanderingProgrammer/render-markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/render-markdown.nvim)

### motion

- [folke/flash.nvim](https://dotfyle.com/plugins/folke/flash.nvim)

### nvim-dev

- [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
- [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
- [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)

### plugin-manager

- [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### programming-languages-support

- [akinsho/flutter-tools.nvim](https://dotfyle.com/plugins/akinsho/flutter-tools.nvim)

### remote-development

- [amitds1997/remote-nvim.nvim](https://dotfyle.com/plugins/amitds1997/remote-nvim.nvim)

### search

- [MagicDuck/grug-far.nvim](https://dotfyle.com/plugins/MagicDuck/grug-far.nvim)

### session

- [folke/persistence.nvim](https://dotfyle.com/plugins/folke/persistence.nvim)

### snippet

- [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)

### split-and-window

- [folke/edgy.nvim](https://dotfyle.com/plugins/folke/edgy.nvim)

### startup

- [echasnovski/mini.starter](https://dotfyle.com/plugins/echasnovski/mini.starter)

### statusline

- [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)

### syntax

- [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)
- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)

### tabline

- [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)

### test

- [fredrikaverpil/neotest-golang](https://dotfyle.com/plugins/fredrikaverpil/neotest-golang)
- [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)

### utility

- [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
- [echasnovski/mini.nvim](https://dotfyle.com/plugins/echasnovski/mini.nvim)
- [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
- [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
- [jellydn/hurl.nvim](https://dotfyle.com/plugins/jellydn/hurl.nvim)
- [GCBallesteros/NotebookNavigator.nvim](https://dotfyle.com/plugins/GCBallesteros/NotebookNavigator.nvim)
- [GCBallesteros/jupytext.nvim](https://dotfyle.com/plugins/GCBallesteros/jupytext.nvim)

### web-development

- [mistweaverco/kulala.nvim](https://dotfyle.com/plugins/mistweaverco/kulala.nvim)

## Language Servers

- gopls
- graphql
- html
- taplo
- vtsls
- yamlls

This readme was generated by [Dotfyle](https://dotfyle.com)
