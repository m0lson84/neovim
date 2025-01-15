--[[
nvim-treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
--]]

return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    opts_extend = { 'ensure_installed' },
    opts = {
      auto_install = true,
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      ensure_installed = {
        'git_config',
        'gitignore',
        'html',
        'kdl',
        'make',
        'query',
        'regex',
        'vim',
        'vimdoc',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
        },
      },
    },
    keys = {
      { '<c-space>', desc = 'increment selection' },
      { '<bs>', desc = 'decrement selection', mode = 'x' },
      { '<leader>it', '<cmd>TSInstallInfo<cr>', desc = '[t]reesitter' },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<c-space>', desc = 'increment selection', mode = { 'x', 'n' } },
        { '<BS>', desc = 'decrement selection', mode = 'x' },
      },
    },
  },
}
