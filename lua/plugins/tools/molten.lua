--[[
molten-nvim (https://github.com/benlubas/molten-nvim)
--]]

---Install the Jupyter kernel in the current project.
local install_kernel = function()
  local python_path = utils.root.venv() .. '/bin/python'
  if vim.fn.executable(python_path) ~= 1 then
    vim.notify('Virtual environment not found at:' .. python_path, vim.log.levels.WARN)
    return
  end

  local install_cmd = string.format('%s -m ipykernel install --user --name=venv', python_path)

  vim.notify('Installing Jupyter kernel for project.')
  local output = vim.fn.system(install_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to install ipykernel: ' .. output, vim.log.levels.ERROR)
    return
  end

  vim.notify('Jupyter kernel successfully installed in project.')
end

return {
  {
    'benlubas/molten-nvim',
    dependencies = { 'willothy/wezterm.nvim' },
    event = 'VeryLazy',
    build = ':UpdateRemotePlugins',
    opts = {
      auto_image_popup = true,
      auto_open_output = false,
      image_provider = 'wezterm',
      output_vert_lines = true,
      output_win_max_height = 20,
      virt_text_output = true,
      wrap_output = true,
    },
    config = function(opts)
      for key, value in ipairs(opts) do
        vim.g.molten_[key] = value
      end
    end,
    keys = {
      { '<leader>ji', install_kernel, desc = '[i]nstall kernel' },
      { '<leader>jk', '<cmd>MoltenInit<cr>', desc = 'select [k]ernel' },
      { '<leader>jsi', '<cmd>MoltenImagePopup<cr>', desc = '[s]how [i]mage' },
      { '<leader>jso', '<cmd>MoltenShowOutput<cr>', desc = '[s]how [o]utput' },
    },
  },
}
