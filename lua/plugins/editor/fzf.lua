--[[
fzf-lua (https://github.com/ibhagwan/fzf-lua)
--]]

return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    fzf_colors = true,
    fzf_opts = {
      ['--no-scrollbar'] = true,
    },
    defaults = {
      formatter = 'path.dirname_first',
    },
    winopts = {
      width = 0.8,
      height = 0.8,
      row = 0.5,
      col = 0.5,
      preview = {
        scrollchars = { '┃', '' },
      },
    },
    lsp = {
      symbols = {
        symbol_hl = function(s) return 'TroubleIcon' .. s end,
        symbol_fmt = function(s) return s:lower() .. '\t' end,
        child_prefix = false,
      },
      code_actions = {
        previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
      },
    },
  },
  keys = {
    { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = '[ ] search files' },
    { '<leader>sb', '<cmd>FzfLua buffers<cr>', desc = '[b]uffers' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = '[d]iagnostics' },
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = '[f]iles' },
    { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'live [g]rep' },
    { '<leader>sh', '<cmd>FzfLua helptags<cr>', desc = '[h]elp' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = '[k]eymaps' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'current [w]ord' },
  },
  config = function(_, opts) require('fzf-lua').setup(opts) end,
}
