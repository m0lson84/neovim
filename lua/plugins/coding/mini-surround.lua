--[[
mini.surround (https://github.com/nvim-mini/mini.nvim)
--]]

return {
  {
    'nvim-mini/mini.surround',
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
    keys = {
      { 'gsa', desc = '[s]urrounding [a]dd', mode = { 'n', 'v' } },
      { 'gsd', desc = '[s]urrounding [d]elete' },
      { 'gsf', desc = '[s]urrounding [f]ind' },
      { 'gsF', desc = '[s]urrounding [F]ind left' },
      { 'gsh', desc = '[s]urrounding [h]ighlight' },
      { 'gsr', desc = '[s]urrounding [r]eplace' },
    },
  },
}
