--[[
mcphub.nvim (https://github.com/ravitemer/mcphub.nvim)
--]]

return {
  {
    'ravitemer/mcphub.nvim',
    build = 'npm install -g mcp-hub@latest',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },
}
