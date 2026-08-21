--[[
obsidian.nvim (https://github.com/obsidian-nvim/obsidian.nvim)
--]]

vim.pack.add({
  'https://github.com/obsidian-nvim/obsidian.nvim',
})

require('obsidian').setup({
  ---@diagnostic disable: missing-fields
  legacy_commands = false,
  workspaces = {
    { name = 'notes', path = '~/source/github/notes' },
  },
  note_id_func = require('obsidian.builtin').title_id,
  note = {
    template = 'note.md',
  },
  frontmatter = {
    sort = { 'context', 'aliases', 'project', 'tags' },
  },
  templates = {
    folder = 'templates',
  },
  daily_notes = {
    folder = 'daily',
  },
  file = {
    ignore_filters = {
      'AGENTS.md',
      'docs/**',
    },
  },
})
