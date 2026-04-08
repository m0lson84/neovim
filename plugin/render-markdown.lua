--[[
render-markdown.nvim (https://github.com/MeanderingProgrammer/render-markdown.nvim)
--]]

vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

require('render-markdown').setup({
  file_types = { 'markdown', 'norg', 'rmd', 'org' },
  heading = { enabled = false },
  latex = { enabled = false },
  code = {
    sign = false,
    width = 'block',
    right_pad = 1,
  },
  completions = {
    lsp = {
      enabled = true,
    },
  },
})
