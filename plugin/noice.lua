--[[ noice.nvim (https://github.com/folke/noice.nvim) --]]

vim.pack.add({
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
})

local function scroll_forward()
  if not require('noice.lsp').scroll(4) then return '<c-f>' end
end

local function scroll_backward()
  if not require('noice.lsp').scroll(-4) then return '<c-b>' end
end

require('noice').setup({
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
    progress = { enabled = false },
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
})

vim.keymap.set('c', '<S-Enter>', function() require('noice').redirect(vim.fn.getcmdline()) end, { desc = 'redirect cmdline' })
vim.keymap.set({ 'i', 'n', 's' }, '<c-b>', scroll_backward, { silent = true, expr = true, desc = 'scroll backward' })
vim.keymap.set({ 'i', 'n', 's' }, '<c-f>', scroll_forward, { silent = true, expr = true, desc = 'scroll forward' })
vim.keymap.set('n', '<leader>sna', function() require('noice').cmd('all') end, { desc = '[a]ll messages' })
vim.keymap.set('n', '<leader>snd', function() require('noice').cmd('dismiss') end, { desc = '[d]ismiss all' })
vim.keymap.set('n', '<leader>snh', function() require('noice').cmd('history') end, { desc = '[h]istory' })
vim.keymap.set('n', '<leader>snl', function() require('noice').cmd('last') end, { desc = '[l]ast message' })
vim.keymap.set('n', '<leader>sns', function() require('noice').cmd('pick') end, { desc = '[s]earch' })
