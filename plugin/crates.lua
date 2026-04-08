--[[
crates.nvim (https://github.com/Saecki/crates.nvim)
--]]

vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'Cargo.toml',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/Saecki/crates.nvim' })
    require('crates').setup({
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
})

vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'Cargo.toml',
  callback = function(args)
    vim.keymap.set('n', 'K', function()
      if require('crates').popup_available() then
        require('crates').show_popup()
      else
        vim.lsp.buf.hover()
      end
    end, { buffer = args.buf, desc = 'show crate docs' })
  end,
})
