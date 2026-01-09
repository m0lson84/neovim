--[[
gitsigns.nvim (https://github.com/lewis6991/gitsigns.nvim)
--]]

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map(
          'v',
          '<leader>hs',
          function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
          { desc = 'stage git hunk' }
        )
        map(
          'v',
          '<leader>hr',
          function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
          { desc = 'reset git hunk' }
        )
        -- normal mode

        map('n', '<leader>ghs', gs.stage_hunk, { desc = '[s]tage' })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = '[r]eset' })
        map('n', '<leader>ghS', gs.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>ghu', gs.stage_hunk, { desc = '[u]ndo stage' })
        map('n', '<leader>ghR', gs.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = '[p]review hunk' })
        map('n', '<leader>ghb', gs.blame_line, { desc = '[b]lame line' })
        map('n', '<leader>ghd', gs.diffthis, { desc = '[d]iff against index' })
        map('n', '<leader>ghD', function() gs.diffthis('@') end, { desc = '[D]iff against last commit' })
      end,
    },
    keys = {
      { '<leader>gh', '', { desc = '[h]unk' } },
    },
  },
}
