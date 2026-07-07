--[[
nvim-lint (https://github.com/mfussenegger/nvim-lint)
--]]

local autocmd = require('util.autocmd')

vim.pack.add({
  'https://github.com/mfussenegger/nvim-lint',
})

require('lint').linters_by_ft = {
  dockerfile = { 'hadolint' },
  dotenv = { 'dotenv_linter' },
  editorconfig = { 'editorconfig-checker' },
  go = { 'golangcilint' },
  markdown = { 'markdownlint-cli2' },
  sql = { 'sqlfluff' },
}

local linters = require('lint').linters
linters['markdownlint-cli2'].args = { '--config', vim.fn.expand('~/.config/nvim/.config/markdownlint.json') }
linters.sqlfluff.args = { 'lint', '--format=json' }

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = autocmd.group('nvim-lint'),
  callback = function() require('lint').try_lint() end,
})

vim.api.nvim_create_user_command('NvimLintInfo', function()
  local ft = vim.bo.filetype
  local linters = require('lint').linters_by_ft[ft]
  vim.notify(
    linters and ('Linters for ' .. ft .. ': \n' .. table.concat(linters, '\n'))
      or ('No linters configured for file type: ' .. ft)
  )
end, { desc = 'Get information about the linters for the current buffer.' })

vim.keymap.set('n', '<leader>in', '<cmd>NvimLintInfo<cr>', { desc = '[n]vim-lint' })
