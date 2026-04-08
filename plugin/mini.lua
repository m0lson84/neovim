--[[
mini.nvim (https://github.com/nvim-mini/mini.nvim)
--]]

vim.pack.add({
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.surround',
})

-- [[ mini.ai ]]

local function ai_buffer(type)
  local start_line, end_line = 1, vim.fn.line('$')
  if type == 'i' then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then return { from = { line = start_line, col = 1 } } end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

-- mini.ai indent text object
-- For "a", it will include the non-whitespace line surrounding the indent block.
-- "a" is line-wise, "i" is character-wise.
local function ai_indent(type)
  local spaces = (' '):rep(vim.o.tabstop)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indents = {} ---@type {line: number, indent: number, text: string}[]

  for l, line in ipairs(lines) do
    if not line:find('^%s*$') then
      indents[#indents + 1] = { line = l, indent = #line:gsub('\t', spaces):match('^%s*'), text = line }
    end
  end

  local region = {}

  for i = 1, #indents do
    if i == 1 or indents[i - 1].indent < indents[i].indent then
      local from, to = i, i
      for j = i + 1, #indents do
        if indents[j].indent < indents[i].indent then break end
        to = j
      end
      from = type == 'a' and from > 1 and from - 1 or from
      to = type == 'a' and to < #indents and to + 1 or to
      region[#region + 1] = {
        indent = indents[i].indent,
        from = { line = indents[from].line, col = type == 'a' and 1 or indents[from].indent + 1 },
        to = { line = indents[to].line, col = #indents[to].text },
      }
    end
  end

  return region
end

local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({ -- code block
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
    t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
    d = { '%f[%d]%d+' }, -- digits
    e = { -- Word with case
      { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
      '^().*()$',
    },
    i = ai_indent, -- indent
    g = ai_buffer, -- buffer
    u = ai.gen_spec.function_call(), -- u for "Usage"
    U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
  },
})

-- [[ mini.icons ]]

require('mini.icons').setup({
  directory = {
    notebooks = { glyph = '󱧶', hl = 'MiniIconsBlue' },
  },
  extension = {
    bash = { glyph = '', hl = 'MiniIconsGrey' },
    ['bash.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['code-workspace'] = { glyph = '󰨞', hl = 'MiniIconsBlue' },
    fish = { glyph = '', hl = 'MiniIconsGrey' },
    ['fish.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['json.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    kdl = { glyph = '', hl = 'MiniIconsYellow' },
    ['kdl.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['ps1.tmpl'] = { glyph = '󰨊', hl = 'MiniIconsGrey' },
    ['sh.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['toml.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['yaml.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
    zsh = { glyph = '', hl = 'MiniIconsGrey' },
    ['zsh.tmpl'] = { glyph = '', hl = 'MiniIconsGrey' },
  },
  file = {
    ['.chezmoiroot'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['.chezmoiversion'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['.dockerignore'] = { glyph = '󰡨', hl = 'MiniIconsBlue' },
    ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsPurple' },
    ['.go-version'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
    ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
    ['.python-version'] = { glyph = '󰌠', hl = 'MiniIconsYellow' },
    ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsPurple' },
    ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
  },
  filetype = {
    curl = { glyph = '', hl = 'MiniIconsRed' },
    dotenv = { glyph = '', hl = 'MiniIconsYellow' },
    gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    http = { glyph = '', hl = 'MiniIconsRed' },
    ['yaml.docker-compose'] = { hl = 'MiniIconsAzure' },
  },
})

-- Mock nvim-web-devicons for plugins that expect it
package.preload['nvim-web-devicons'] = function()
  require('mini.icons').mock_nvim_web_devicons()
  return package.loaded['nvim-web-devicons']
end

-- [[ mini.pairs ]]

local pairs_opts = {
  modes = { insert = true, command = true, terminal = false },
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  skip_ts = { 'string' },
  skip_unbalanced = true,
  markdown = true,
}

local pairs = require('mini.pairs')
pairs.setup(pairs_opts)

local open = pairs.open
pairs.open = function(pair, neigh_pattern)
  if vim.fn.getcmdline() ~= '' then return open(pair, neigh_pattern) end

  local o, c = pair:sub(1, 1), pair:sub(2, 2)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local next = line:sub(cursor[2] + 1, cursor[2] + 1)
  local before = line:sub(1, cursor[2])

  if pairs_opts.markdown and o == '`' and vim.bo.filetype == 'markdown' and before:match('^%s*``') then
    return '`\n```' .. vim.api.nvim_replace_termcodes('<up>', true, true, true)
  end

  if pairs_opts.skip_next and next ~= '' and next:match(pairs_opts.skip_next) then return o end

  if pairs_opts.skip_ts and #pairs_opts.skip_ts > 0 then
    local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
    for _, capture in ipairs(ok and captures or {}) do
      if vim.tbl_contains(pairs_opts.skip_ts, capture.capture) then return o end
    end
  end

  if pairs_opts.skip_unbalanced and next == c and c ~= o then
    local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), '')
    local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), '')
    if count_close > count_open then return o end
  end

  return open(pair, neigh_pattern)
end

-- [[ mini.surround ]]

require('mini.surround').setup({
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    update_n_lines = 'gsn',
  },
})
