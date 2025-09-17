--[[
lazy.nvim configuration
--]]

-- Path to lazy.nvim installation
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Check if lazy.nvim is installed
if not vim.uv.fs_stat(lazy_path) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazy_path })
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

-- Add lazy.nvim to runtime path
vim.o.rtp = lazy_path .. ',' .. vim.o.rtp
