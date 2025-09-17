--[[
-- iron.nvim (https://github.com/Vigemus/iron.nvim)
--]]

---Clear output of the current REPL.
local function clear()
  return function() require('iron.core').send(nil, string.char(12)) end
end

---Exit the current REPL.
local function exit()
  return function() require('iron.core').close_repl() end
end

---Interrupt execution of the current REPL.
local function interrupt()
  return function() require('iron.core').send(nil, string.char(03)) end
end

---Send enter to the current REPL.
local function send_enter()
  return function() require('iron.core').send(nil, string.char(13)) end
end

return {
  {
    'Vigemus/iron.nvim',
    event = 'VeryLazy',
    main = 'iron.core',
    opts = function()
      return {
        highlight = { italic = true },
        ignore_blank_lines = true,
        config = {
          scratch_repl = true,
          repl_definition = {
            javascript = require('iron.fts.javascript').node,
            python = require('iron.fts.python').ipython,
            sh = require('iron.fts.sh').zsh,
            typescript = require('iron.fts.typescript').ts,
          },
          repl_open_cmd = function(bufnr)
            vim.api.nvim_set_option_value('filetype', 'iron', { buf = bufnr })
            return require('iron.view').split.vertical.botright(40)(bufnr)
          end,
        },
      }
    end,
    keys = {
      { '<leader>ro', '<cmd>IronReplHere<cr>', desc = '[o]pen repl' },
      { '<leader>r<cr>', send_enter(), desc = 'send enter' },
      { '<leader>r<space>', interrupt(), desc = 'interrupt execution' },
      { '<leader>rr', '<cmd>IronRestart<cr>', desc = '[r]estart repl' },
      { '<leader>rc', clear(), desc = '[c]lear repl' },
      { '<leader>rq', exit(), desc = '[q]uit repl' },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>r', group = '[r]EPL', icon = { icon = '', color = 'green' } },
      },
    },
  },
}
