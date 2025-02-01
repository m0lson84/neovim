--[[
mini.starter (https://github.com/echasnovski/mini.nvim)
--]]

return {
  {
    'echasnovski/mini.starter',
    version = false,
    dependencies = { 'MaximilianLloyd/ascii.nvim' },
    event = 'VimEnter',
    opts = function()
      local starter = require('mini.starter')
      local logo = table.concat(require('ascii').get_random('text', 'neovim'), '\n')
      local pad = string.rep(' ', 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local config = {
        evaluate_single = true,
        header = logo,
        items = {
          new_section('New file', 'ene | startinsert', 'Built-in'),
          new_section('Quit Neovim', 'qall', 'Built-in'),
          new_section('Restore session', [[lua require("persistence").load()]], 'Session'),
          new_section('lazy.nvim', 'Lazy', 'Config'),
          new_section('Mason', 'Mason', 'Config'),
          new_section('Find files', [[lua require("snacks").picker.files()]], 'Search'),
          new_section('Live grep', [[lua require("snacks").picker.grep()]], 'Search'),
          new_section('Recent files', [[lua require("snacks").picker.recent()]], 'Search'),
          new_section('Command history', [[lua require("snacks").picker.command_history()]], 'Search'),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. '░ ', false),
          starter.gen_hook.aligning('center', 'center'),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniStarterOpened',
          callback = function() require('lazy').show() end,
        })
      end

      local starter = require('mini.starter')
      starter.setup(config)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function(ev)
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(' ', 8)
          starter.config.footer = pad_footer
            .. '⚡ Neovim loaded '
            .. stats.loaded
            .. '/'
            .. stats.count
            .. ' plugins in '
            .. ms
            .. 'ms'
          if vim.bo[ev.buf].filetype == 'ministarter' then pcall(starter.refresh) end
        end,
      })
    end,
  },
}
