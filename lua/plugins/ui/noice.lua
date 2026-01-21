--[[
noice.nvim (https://github.com/folke/noice.nvim)
--]]

--- Scroll forward
local scroll_forward = function()
  if not require('noice.lsp').scroll(4) then return '<c-f>' end
end

--- Scroll backward
local scroll_backward = function()
  if not require('noice.lsp').scroll(-4) then return '<c-b>' end
end

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { '<leader>sn', '', desc = '[n]oice'},
      { '<S-Enter>', function() require('noice').redirect(vim.fn.getcmdline()) end, mode = '', desc = 'redirect cmdline' },
      { '<leader>sna', function() require('noice').cmd('all') end, desc = '[a]ll messages' },
      { '<leader>snd', function() require('noice').cmd('dismiss') end, desc = '[d]ismiss all' },
      { '<leader>snh', function() require('noice').cmd('history') end, desc = '[h]istory' },
      { '<leader>snl', function() require('noice').cmd('last') end, desc = '[l]ast Message' },
      { '<leader>sns', function() require('noice').cmd('pick') end, desc = '[s]earch' },
      { '<c-f>', scroll_forward, mode = {'i', 'n', 's'}, silent = true, expr = true, desc = 'scroll forward'},
      { '<c-b>', scroll_backward, mode = {'i', 'n', 's'}, silent = true, expr = true, desc = 'scroll backward'},
    },
    config = function(_, opts)
      if vim.o.filetype == 'lazy' then vim.cmd([[messages clear]]) end
      require('noice').setup(opts)
    end,
  },
}
