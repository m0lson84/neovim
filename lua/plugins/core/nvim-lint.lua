--[[
nvim-lint (https://github.com/mfussenegger/nvim-lint)
--]]

return {

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'editorconfig-checker' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = { editorconfig = { 'editorconfig-checker' } },
      linters = {},
    },
    keys = {
      { '<leader>in', '<cmd>NvimLintInfo<cr>', desc = '[n]vim-lint' },
    },
    config = function(_, opts)
      local M = {}

      local lint = require('lint')
      for name, linter in pairs(opts.linters) do
        if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
          lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
          if type(linter.prepend_args) == 'table' then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      --- Debounce a function.
      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      --- Get information about the linters for the current buffer.
      ---@param ft string The filetype to get information about.
      function M.info(ft)
        local linters = require('lint').linters_by_ft[ft]
        vim.notify(
          linters and ('Linters for ' .. ft .. ': \n' .. table.concat(linters, '\n'))
            or ('No linters configured for file type: ' .. ft)
        )
      end

      --- Run linters on the current buffer.
      function M.lint()
        local logger = utils.get_logger()

        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then vim.list_extend(names, lint.linters_by_ft['_'] or {}) end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft['*'] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = {
          filename = vim.api.nvim_buf_get_name(0),
          filetype = vim.bo.filetype,
        }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then logger.warn('Linter not found: ' .. name, { title = 'nvim-lint' }) end
          return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then lint.try_lint(names) end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = M.debounce(100, M.lint),
      })

      vim.api.nvim_create_user_command('NvimLintInfo', function() M.info(vim.bo.filetype) end, {
        desc = 'Get information about the linters for the current buffer.',
      })
    end,
  },
}
