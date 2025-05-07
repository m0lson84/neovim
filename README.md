# neovim

<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/m0lson84/neovim"><img src="https://dotfyle.com/m0lson84/neovim/badges/plugin-manager?style=for-the-badge" /></a>

## Requirements

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)

## Install

> Install requires Neovim 0.11+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone https://github.com/m0lson84/neovim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

Open Neovim with this config:

```sh
NVIM_APPNAME=m0lson84/neovim/ nvim
```

## Language Support

- bash
- dart/flutter
- go
- js/ts
- latex
- lua
- markdown
- python
- rust

## Plugins

### core

- [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
- [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim)
- [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
- [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
- [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
- [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)
- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
- [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
- [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### ai

- [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
- [CopilotC-Nvim/CopilotChat.nvim](https://dotfyle.com/plugins/CopilotC-Nvim/CopilotChat.nvim)

### coding

- [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
- [echasnovski/mini.ai](https://dotfyle.com/plugins/echasnovski/mini.ai)
- [echasnovski/mini.pairs](https://dotfyle.com/plugins/echasnovski/mini.pairs)
- [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)
- [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
- [folke/ts-comments.nvim](https://dotfyle.com/plugins/folke/ts-comments.nvim)
- [gbprod/yanky.nvim](https://dotfyle.com/plugins/gbprod/yanky.nvim)
- [saghen/blink.cmp](https://dotfyle.com/plugins/Saghen/blink.cmp)
- [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)

### editor

- [folke/flash.nvim](https://dotfyle.com/plugins/folke/flash.nvim)
- [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
- [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
- [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
- [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
- [lukas-reineke/virt-column.nvim](https://dotfyle.com/plugins/lukas-reineke/virt-column.nvim)
- [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)
- [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
- [magicduck/grug-far.nvim](https://dotfyle.com/plugins/MagicDuck/grug-far.nvim)

### tools

- [folke/persistence.nvim](https://dotfyle.com/plugins/folke/persistence.nvim)
- [gcballesteros/jupytext.nvim](https://dotfyle.com/plugins/GCBallesteros/jupytext.nvim)
- [jellydn/hurl.nvim](https://dotfyle.com/plugins/jellydn/hurl.nvim)
- [mistweaverco/kulala.nvim](https://dotfyle.com/plugins/mistweaverco/kulala.nvim)
- [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
- [Vigemus/iron.nvim](https://dotfyle.com/plugins/Vigemus/iron.nvim)

### ui

- [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)
- [echasnovski/mini.icons](https://dotfyle.com/plugins/echasnovski/mini.icons)
- [echasnovski/mini.indentscope](https://dotfyle.com/plugins/echasnovski/mini.indentscope)
- [echasnovski/mini.starter](https://dotfyle.com/plugins/echasnovski/mini.starter)
- [folke/edgy.nvim](https://dotfyle.com/plugins/folke/edgy.nvim)
- [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
- [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
- [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
- [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
- [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
- [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
