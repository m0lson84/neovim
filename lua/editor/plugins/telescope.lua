--[[
telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)
--]]

--- Search in current buffer
local search_buffer = function()
  local builtin = require('telescope.builtin')
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

--- Live Grep in open files
local search_files = function()
  local builtin = require('telescope.builtin')
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    version = false,
    event = 'VimEnter',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable('make') == 1 end,
      },
    },
    opts = function()
      return {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[ ] search files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[b]uffers' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[d]iagnostics' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[f]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'live [g]rep' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[h]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[k]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]elect telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'current [w]ord' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
      vim.keymap.set('n', '<leader>/', search_buffer, { desc = '[/] search in current buffer' })
      vim.keymap.set('n', '<leader>s/', search_files, { desc = '[s]earch [/] in open files' })
    end,
  },
}
