--[[
rustaceanvim (https://github.com/mrcjkb/rustaceanvim)
--]]

vim.pack.add({ 'https://github.com/mrcjkb/rustaceanvim' })

vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, {
  server = {
    load_vscode_settings = true,
    default_settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = { enable = true },
        },
        procMacro = {
          enable = true,
          ignored = {
            ['async-trait'] = { 'async_trait' },
            ['napi-derive'] = { 'napi' },
            ['async-recursion'] = { 'async_recursion' },
          },
        },
      },
    },
    on_attach = function(_, bufnr)
      vim.keymap.set(
        'n',
        '<leader>cA',
        function() vim.cmd.RustLsp('codeAction') end,
        { desc = 'rust [A]ctions', buffer = bufnr }
      )
      vim.keymap.set(
        'n',
        '<leader>dr',
        function() vim.cmd.RustLsp('debuggables') end,
        { desc = '[r]ust debuggables', buffer = bufnr }
      )
    end,
  },
})
