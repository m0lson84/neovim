--[[
nvim-lint (https://github.com/mfussenegger/nvim-lint)
--]]

local autocmd = require('util.autocmd')

vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

local function debounce(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

local function do_lint()
  local lint = require('lint')
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  names = vim.list_extend({}, names)
  if #names == 0 then vim.list_extend(names, lint.linters_by_ft['_'] or {}) end
  vim.list_extend(names, lint.linters_by_ft['*'] or {})

  local ctx = { filename = vim.api.nvim_buf_get_name(0), filetype = vim.bo.filetype }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then vim.notify('Linter not found: ' .. name, vim.log.levels.WARN) end
    return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
  end, names)

  if #names > 0 then lint.try_lint(names) end
end

vim.schedule(function()
  local lint = require('lint')

  lint.linters_by_ft = {
    dockerfile = { 'hadolint' },
    dotenv = { 'dotenv_linter' },
    editorconfig = { 'editorconfig-checker' },
    fish = { 'fish' },
    go = { 'golangcilint' },
    markdown = { 'markdownlint-cli2' },
    proto = { 'buf_lint' },
    sql = { 'sqlfluff' },
  }

  lint.linters.dotenv_linter = vim.tbl_deep_extend('force', lint.linters.dotenv_linter or {}, {})
  lint.linters.golangcilint = vim.tbl_deep_extend('force', lint.linters.golangcilint or {}, {})
  lint.linters.hadolint = vim.tbl_deep_extend('force', lint.linters.hadolint or {}, {})
  lint.linters['markdownlint-cli2'] = vim.tbl_deep_extend('force', lint.linters['markdownlint-cli2'] or {}, {
    args = { '--config', vim.fn.expand('~/.config/nvim/.config/markdownlint.json') },
  })
  lint.linters.sqlfluff = vim.tbl_deep_extend('force', lint.linters.sqlfluff or {}, {
    args = { 'lint', '--format=json' },
  })
end)

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = autocmd.group('nvim-lint'),
  callback = debounce(100, do_lint),
})

vim.api.nvim_create_user_command('NvimLintInfo', function()
  local lint = require('lint')
  local ft = vim.bo.filetype
  local linters = lint.linters_by_ft[ft]
  vim.notify(
    linters and ('Linters for ' .. ft .. ': \n' .. table.concat(linters, '\n'))
      or ('No linters configured for file type: ' .. ft)
  )
end, { desc = 'Get information about the linters for the current buffer.' })

vim.keymap.set('n', '<leader>in', '<cmd>NvimLintInfo<cr>', { desc = '[n]vim-lint' })
