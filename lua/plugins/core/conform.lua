--[[
conform.nvim (https://github.com/stevearc/conform.nvim)
--]]

-- Format the current buffer
local function format_buffer()
  return function() require('conform').format({ async = true }) end
end

-- Format injected languages in current buffer
local function format_injected()
  return function() require('conform').format({ formatters = { 'injected' } }) end
end

return {
  {
    'stevearc/conform.nvim',
    lazy = true,
    dependencies = { 'mason-org/mason.nvim' },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {},
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = 'fallback',
      },
      format_on_save = { timeout_ms = 3000 },
    },
    keys = {
      { '<leader>cf', format_buffer(), mode = { 'n', 'v' }, desc = '[f]ormat buffer' },
      { '<leader>cF', format_injected(), mode = { 'n', 'v' }, desc = '[F]ormat injected langs' },
      { '<leader>ic', '<cmd>ConformInfo<cr>', desc = '[c]onform' },
    },
  },
}
