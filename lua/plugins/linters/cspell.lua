--[[
CSpell (https://cspell.org/)
--]]

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'cspell' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      linters = {
        cspell = {
          condition = function(ctx)
            local ignored = { 'snacks_picker_input', 'snacks_picker_list' }
            for _, ft in ipairs(ignored) do
              if ft == ctx.filetype then return false end
            end
            return true
          end,
        },
      },
      linters_by_ft = {
        ['*'] = { 'cspell' },
      },
    },
  },
}
