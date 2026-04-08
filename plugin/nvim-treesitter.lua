--[[
nvim-treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
--]]

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

local function have_parser(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and pcall(vim.treesitter.language.inspect, lang)
end

require('nvim-treesitter').setup({})
require('nvim-treesitter').install({
  'bash',
  'bicep',
  'c_sharp',
  'css',
  'dockerfile',
  'fish',
  'git_config',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'gowork',
  'html',
  'http',
  'hurl',
  'javascript',
  'json',
  'json5',
  'kdl',
  'lua',
  'luadoc',
  'luap',
  'make',
  'markdown',
  'markdown_inline',
  'mermaid',
  'ninja',
  'proto',
  'python',
  'query',
  'regex',
  'ron',
  'rst',
  'rust',
  'scss',
  'sql',
  'templ',
  'toml',
  'tsx',
  'typescript',
  'typst',
  'vim',
  'vimdoc',
  'yaml',
  'zig',
})

require('treesitter-context').setup({
  enabled = true,
  mode = 'cursor',
  max_lines = 3,
})

require('nvim-treesitter-textobjects').setup({})

vim.treesitter.language.register('bash', { 'dotenv', 'sh', 'zsh' })

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if have_parser(args.match) then pcall(vim.treesitter.start) end
    vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
  end,
})

vim.keymap.set('n', '<leader>it', function()
  local installed = require('nvim-treesitter').get_installed('parsers')
  vim.notify_once('Installed parsers:\n\n' .. table.concat(installed, ', '))
end, { desc = '[t]reesitter' })

local moves = {
  goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
  goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
  goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
  goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
}

for method, keymaps in pairs(moves) do
  for key, query in pairs(keymaps) do
    local desc = query:gsub('@', ''):gsub('%..*', '')
    desc = desc:sub(1, 1):upper() .. desc:sub(2)
    desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
    desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
    vim.keymap.set({ 'n', 'x', 'o' }, key, function()
      if vim.wo.diff and key:find('[cC]') then return vim.cmd('normal! ' .. key) end
      require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
    end, { desc = desc, silent = true })
  end
end
