--[[
mason.nvim (https://github.com/mason-org/mason.nvim)
--]]

return {
  {

    'mason-org/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {},
      ui = { border = vim.g.window_border },
    },
    keys = { { '<leader>nm', '<cmd>Mason<cr>', desc = '[m]ason' } },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(
          function()
            require('lazy.core.handler.event').trigger({
              event = 'FileType',
              buf = vim.api.nvim_get_current_buf(),
            })
          end,
          100
        )
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    config = function() end,
  },
}
