--[[
Tooling plugin configurations
--]]

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  require('tools.plugins.diffview'),
  require('tools.plugins.hurl'),
  require('tools.plugins.iron'),
  require('tools.plugins.jupytext'),
  require('tools.plugins.kulala'),
  require('tools.plugins.molten'),
  require('tools.plugins.notebook'),
  require('tools.plugins.persistence'),
  require('tools.plugins.remote'),
}
