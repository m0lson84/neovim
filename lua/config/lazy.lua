--[[
lazy.nvim configuration
--]]

-- Path to lazy.nvim installation
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Check if lazy.nvim is installed
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)
