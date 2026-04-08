--[[
mason.nvim (https://github.com/mason-org/mason.nvim)
--]]

vim.schedule(function()
  vim.pack.add({
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
  })

  local ensure_installed = {
    'bicep-lsp',
    'csharpier',
    'delve',
    'dotenv-linter',
    'editorconfig-checker',
    'golangci-lint',
    'hadolint',
    'js-debug-adapter',
    'markdownlint-cli2',
    'netcoredbg',
    'prettierd',
    'shellcheck',
    'shfmt',
    'sqlfluff',
    'sqlfmt',
    'stylua',
    'taplo',
    'templ',
    'typstyle',
  }

  require('mason').setup({
    ui = { border = 'rounded' },
  })

  local mr = require('mason-registry')
  mr:on('package:install:success', function()
    vim.defer_fn(
      function() vim.api.nvim_exec_autocmds('FileType', { buffer = vim.api.nvim_get_current_buf() }) end,
      100
    )
  end)

  mr.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local ok, p = pcall(mr.get_package, tool)
      if ok and not p:is_installed() then p:install() end
    end
  end)

  require('mason-lspconfig').setup({
    automatic_enable = false,
  })
end)

vim.keymap.set('n', '<leader>nm', '<cmd>Mason<cr>', { desc = '[m]ason' })
