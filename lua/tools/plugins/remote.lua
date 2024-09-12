--[[
remote.nvim (https://github.com/amitds1997/remote-nvim.nvim)
--]]

--- Remote startup callback.
---@param port number Port of the remote server.
---@param workspace table Configuration of the development workspace.
local client_launch = function(port, workspace)
  local spawn_client = ('wezterm cli spawn nvim --server localhost:%s --remote-ui'):format(port)
  local cmd = ('wezterm cli set-tab-title --pane-id $(%s) \'Remote: %s\''):format(spawn_client, workspace.host)
  vim.fn.jobstart(cmd, {
    detach = true,
    on_exit = function(job_id, exit_code, event_type)
      print('Job', job_id, 'exited with code', exit_code, 'Event type:', event_type)
    end,
  })
end

--- Cleanup Neovim installation from remote.
local cleanup_remote = function() return '<cmd>RemoteCleanup ' .. vim.fn.input('Workspace: ') .. '<cr>' end

--- Create a development container.
local create_container = function()
  local logger = utils.get_logger()
  local command = 'devpod up %s --id %s --devcontainer-path .devcontainer/devcontainer.json --ide none'
  local result = vim.api.nvim_cmd({ (command):format(vim.fn.getcwd(), vim.fn.input('Workspace: ')) }, { output = true })
  for _, line in pairs(utils.split_string(result, '\n')) do
    logger.debug(line)
  end
end

--- Delete workspace configuration.
local delete_config = function() return '<cmd>RemoteConfigDel ' .. vim.fn.input('Workspace: ') .. '<cr>' end

--- Path to the Neovim installation script.
local install_script = function() return utils.path.join(vim.fn.stdpath('config'), 'scripts', 'install.sh') end

--- Stop remote session.
local stop_session = function() return '<cmd>RemoteStop ' .. vim.fn.input('Workspace: ') .. '<cr>' end

return {
  {
    'amitds1997/remote-nvim.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>Rn', create_container, desc = '[n]ew container' },
      { '<leader>Rs', '<cmd>RemoteStart<cr>', desc = '[s]tart session' },
      { '<leader>RS', stop_session, desc = '[S]top session' },
      { '<leader>Ri', '<cmd>RemoteInfo<cr>', desc = 'session [i]nfo' },
      { '<leader>Rc', cleanup_remote, desc = '[c]leanup remote' },
      { '<leader>Rd', delete_config, desc = '[d]elete configuration' },
      { '<leader>Rl', '<cmd>RemoteLog<cr>', desc = 'open [l]ogs' },
    },
    opts = {
      client_callback = client_launch,
      neovim_install_script_path = install_script(),
      log = { level = 'debug' },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>R', group = '[R]emote', icon = { icon = '󰢹', color = 'blue' } },
        { '<leader>Rc', name = '[c]leanup remote', icon = { icon = '󰃢', color = 'yellow' } },
        { '<leader>Rd', name = '[d]elete configuration', icon = { icon = '', color = 'orange' } },
        { '<leader>Ri', name = 'session [i]nfo', icon = { icon = '', color = 'azure' } },
        { '<leader>Rl', name = 'open [l]ogs', icon = { icon = '', color = 'blue' } },
        { '<leader>Rn', name = '[n]ew container', icon = { icon = '', color = 'cyan' } },
        { '<leader>Rs', name = '[s]tart session', icon = { icon = '', color = 'green' } },
        { '<leader>RS', name = '[S]top session', icon = { icon = '', color = 'red' } },
      },
    },
  },
}
