--[[
Core plugin configurations
--]]

return {
  require('core.plugins.conform'),
  require('core.plugins.lspconfig'),
  require('core.plugins.mason'),
  require('core.plugins.neotest'),
  require('core.plugins.nvim-dap'),
  require('core.plugins.nvim-lint'),
  require('core.plugins.tokyonight'),
  require('core.plugins.treesitter'),
}
