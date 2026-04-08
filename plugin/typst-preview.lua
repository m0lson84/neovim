--[[
typst-preview.nvim (https://github.com/chomosuke/typst-preview.nvim)
--]]

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/chomosuke/typst-preview.nvim' })
    require('typst-preview').setup({
      dependencies_bin = {
        tinymist = 'tinymist',
      },
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function(args)
    vim.keymap.set('n', '<leader>cp', '<cmd>TypstPreview<cr>', { buf = args.buf, desc = '[p]review doc' })
  end,
})
