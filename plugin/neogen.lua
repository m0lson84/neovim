--[[
Neogen (https://github.com/danymat/neogen)
--]]

vim.pack.add({ 'https://github.com/danymat/neogen' })

local file_types = {
  'bash',
  'cs',
  'go',
  'javascript',
  'lua',
  'python',
  'rust',
  'sh',
  'typescript',
  'zsh',
}

require('neogen').setup({
  languages = {
    cs = { template = { annotation_convention = 'xmldoc' } },
    go = { template = { annotation_convention = 'godoc' } },
    javascript = { template = { annotation_convention = 'jsdoc' } },
    javascriptreact = { template = { annotation_convention = 'jsdoc' } },
    lua = { template = { annotation_convention = 'emmylua' } },
    python = { template = { annotation_convention = 'google_docstrings' } },
    rust = { template = { annotation_convention = 'rustdoc' } },
    sh = { template = { annotation_convention = 'google_bash' } },
    typescript = { template = { annotation_convention = 'jsdoc' } },
    typescriptreact = { template = { annotation_convention = 'jsdoc' } },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = file_types,
  callback = function(args)
    vim.keymap.set(
      'n',
      '<leader>cD',
      function() require('neogen').generate({ type = 'any', snippet_engine = 'nvim' }) end,
      { buffer = args.buf, desc = 'generate [D]ocs' }
    )
  end,
})

vim.keymap.set(
  'n',
  '<leader>cD',
  function() require('neogen').generate({ type = 'any', snippet_engine = 'nvim' }) end,
  { desc = 'generate [D]ocs' }
)
