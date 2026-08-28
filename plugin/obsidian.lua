--[[
obsidian.nvim (https://github.com/obsidian-nvim/obsidian.nvim)
--]]

vim.pack.add({
  'https://github.com/obsidian-nvim/obsidian.nvim',
})

local notes = vim.fn.expand('~/source/github/notes')
if not vim.uv.fs_stat(notes) then return end

require('obsidian').setup({
  ---@diagnostic disable: missing-fields
  legacy_commands = false,
  workspaces = {
    { name = 'notes', path = notes },
  },
  note_id_func = require('obsidian.builtin').title_id,
  note = {
    template = 'note.md',
  },
  file = {
    ignore_filters = {
      'AGENTS.md',
      'docs/**',
    },
  },
  frontmatter = {
    sort = { 'context', 'aliases', 'project', 'tags' },
    func = function(note)
      local meta = note.metadata or {}
      local out = { context = meta.context, project = meta.project, date = meta.date, tags = note.tags }
      if #note.aliases > 0 then out.aliases = note.aliases end
      return out
    end,
  },
  templates = {
    folder = 'templates',
  },
  daily_notes = {
    folder = 'daily',
  },
  ui = {
    enable = false,
  },
})
