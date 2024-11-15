--[[
neo-tree.nvim (https://github.com/nvim-neo-tree/neo-tree.nvim)
--]]

local explore = function(dir)
  return function() require('neo-tree.command').execute({ toggle = true, dir = dir }) end
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    deactivate = function() vim.cmd([[Neotree close]]) end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then require('neo-tree') end
          end
        end,
      })
    end,
    opts = {
      sources = { 'filesystem' },
      open_files_do_not_replace_types = { 'edgy', 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          never_show = {
            '__pycache__',
            '.DS_Store',
            'thumbs.db',
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    keys = {
      { '<leader>e', '<leader>fe', desc = '[e]xplorer cwd', remap = true },
      { '<leader>fe', explore(vim.uv.cwd()), desc = '[e]xplorer cwd' },
      { '<leader>fE', explore(utils.root()), desc = '[e]xplorer root' },
    },
    config = function(_, opts)
      local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function() events.fire_event(events.GIT_EVENT) end,
      })
    end,
  },
}
