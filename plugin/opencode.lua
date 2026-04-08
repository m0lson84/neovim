--[[
opencode.nvim (https://github.com/NickvanDyke/opencode.nvim)
--]]

vim.pack.add({ 'https://github.com/nickjvandyke/opencode.nvim' })

---@param default? string Text to prefill the input with.
local function ask_prompt(default)
  return function() require('opencode').ask(default) end
end

vim.g.opencode_opts = {}
vim.o.autoread = true

vim.keymap.set('n', '<leader>aa', ask_prompt('@buffer '), { desc = '[a]sk opencode' })
vim.keymap.set('v', '<leader>aa', ask_prompt('@this: '), { desc = '[a]sk selection' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', function() require('opencode').select() end, { desc = 'select [p]rompt' })
vim.keymap.set('n', '<leader>an', function() require('opencode').command('session.new') end, { desc = '[n]ew session' })
vim.keymap.set('n', '<leader>as', function() require('opencode').select_server() end, { desc = '[s]elect server' })
