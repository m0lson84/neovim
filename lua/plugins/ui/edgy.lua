--[[
edgy.nvim (https://github.com/folke/edgy.nvim)
--]]

local size = {
  left = { width = 0.2 },
  right = { width = 0.3 },
  bottom = { height = 0.25 },
}

return {
  {
    'folke/edgy.nvim',
    opts = function()
      local opts = {
        animate = { enabled = false },
        bottom = {
          {
            title = 'Terminal',
            ft = 'toggleterm',
            size = size['bottom'],
            filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == '' end,
          },
          {
            title = 'REPL',
            ft = 'iron',
            size = { height = 0.25 },
            filter = function(buf) return require('iron.lowlevel').repl_exists({ bufnr = buf }) end,
          },
          {
            title = 'Help',
            ft = 'help',
            size = size['bottom'],
            filter = function(buf) return vim.bo[buf].buftype == 'help' end,
          },
          'Trouble',
          { title = 'QuickFix', ft = 'qf' },
          { title = 'Test Output', ft = 'neotest-output-panel', size = size['bottom'] },
        },
        left = {
          {
            title = 'Explorer',
            ft = 'neo-tree',
            filter = function(buf) return vim.b[buf].neo_tree_source == 'filesystem' end,
            open = function() vim.api.nvim_input('<esc><space>e') end,
            size = size['left'],
          },
          { title = 'Test Summary', ft = 'neotest-summary', size = size['left'] },
        },
        right = {
          { title = 'Grug Far', ft = 'grug-far', size = size['right'] },
          { title = 'Response', ft = 'hurl-nvim', size = size['right'] },
        },
        keys = {
          ['<c-Right>'] = function(win) win:resize('width', 2) end,
          ['<c-Left>'] = function(win) win:resize('width', -2) end,
          ['<c-Up>'] = function(win) win:resize('height', 2) end,
          ['<c-Down>'] = function(win) win:resize('height', -2) end,
        },
      }

      for _, pos in ipairs({ 'bottom', 'left', 'right' }) do
        table.insert(opts[pos], {
          ft = 'trouble',
          filter = function(_, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == 'split'
              and vim.w[win].trouble.relative == 'editor'
              and not vim.w[win].trouble_preview
          end,
          size = size[pos],
        })
      end
      return opts
    end,
  },
}
