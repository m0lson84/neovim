--[[
vivify.vim (https://github.com/jannis-baum/vivify.vim)
--]]

vim.pack.add({ 'https://github.com/jannis-baum/vivify.vim' })

vim.g.vivify_filetypes = { 'vimwiki' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<leader>cp', '<cmd>Vivify<cr>', { buf = args.buf, desc = '[p]review doc' })
  end,
})
