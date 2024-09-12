--[[
Linting plugin configuration
--]]

return {
  require('linters.plugins.biome'),
  require('linters.plugins.cspell'),
  require('linters.plugins.eslint'),
  require('linters.plugins.hadolint'),
  require('linters.plugins.markdownlint'),
  require('linters.plugins.ruff'),
  require('linters.plugins.sqlfluff'),
}
