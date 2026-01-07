--[[
nvim-treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
--]]

--- Show the list of installed language parsers.
local function install_info()
  return function()
    local installed = require('nvim-treesitter').get_installed('parsers')
    vim.notify_once('Installed parsers:\n\n' .. table.concat(installed, ', '))
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    version = false,
    lazy = false,
    opts_extend = { 'ensure_installed' },
    opts = {
      auto_install = true,
      ensure_installed = {
        'git_config',
        'gitignore',
        'kdl',
        'make',
        'query',
        'regex',
        'vim',
        'vimdoc',
      },
    },
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      ts.setup(opts)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          if utils.treesitter.have(args.match) then pcall(vim.treesitter.start) end
          vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
        end,
      })
    end,
    keys = {
      { '<c-space>', desc = 'increment selection' },
      { '<bs>', desc = 'decrement selection', mode = 'x' },
      { '<leader>it', install_info(), desc = '[t]reesitter' },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    opts = {},
    keys = function()
      local moves = {
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
      }
      local ret = {}
      for method, keymaps in pairs(moves) do
        for key, query in pairs(keymaps) do
          local desc = query:gsub('@', ''):gsub('%..*', '')
          desc = desc:sub(1, 1):upper() .. desc:sub(2)
          desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
          ret[#ret + 1] = {
            key,
            function()
              -- don't use treesitter if in diff mode and the key is one of the c/C keys
              if vim.wo.diff and key:find('[cC]') then return vim.cmd('normal! ' .. key) end
              require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
            end,
            desc = desc,
            mode = { 'n', 'x', 'o' },
            silent = true,
          }
        end
      end
      return ret
    end,
  },

  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<c-space>', desc = 'increment selection', mode = { 'x', 'n' } },
        { '<BS>', desc = 'decrement selection', mode = 'x' },
      },
    },
  },
}
