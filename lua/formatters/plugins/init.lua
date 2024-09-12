--[[
Formatting plugin configurations
--]]

return {
  require('formatters.plugins.csharpier'),
  require('formatters.plugins.gofumpt'),
  require('formatters.plugins.goimports'),
  require('formatters.plugins.prettier'),
  require('formatters.plugins.rustfmt'),
  require('formatters.plugins.shfmt'),
  require('formatters.plugins.sqlfmt'),
  require('formatters.plugins.stylua'),
  require('formatters.plugins.taplo'),
}
