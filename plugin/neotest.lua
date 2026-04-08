--[[
neotest (https://github.com/nvim-neotest/neotest)
--]]

local initialized = false
local function ensure_init()
  if initialized then return end
  initialized = true

  vim.pack.add({
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/mrcjkb/rustaceanvim',
    'https://github.com/nsidorenco/neotest-vstest',
    'https://github.com/fredrikaverpil/neotest-golang',
    'https://github.com/nvim-neotest/neotest-python',
    'https://github.com/nvim-neotest/neotest-jest',
    'https://github.com/marilari88/neotest-vitest',
    'https://github.com/lawrence-laz/neotest-zig',
  })

  local function find_config(file_name)
    return function()
      local file = vim.fn.expand('%:p')
      if string.find(file, '/packages/') then return string.match(file, '(.-/[^/]+/)src') .. file_name end
      return vim.fn.getcwd() .. '/' .. file_name
    end
  end

  local neotest_ns = vim.api.nvim_create_namespace('neotest')
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        return diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
      end,
    },
  }, neotest_ns)

  local adapters = {
    require('neotest-vstest')({ dap_settings = { type = 'netcoredbg' } }),
    require('neotest-golang')({ runner = 'gotestsum' }),
    require('neotest-python')({
      runner = 'pytest',
      python = './.venv/bin/python',
      args = { '--log-level', 'DEBUG' },
      dap = { justMyCode = true },
    }),
    require('neotest-jest')({
      jestCommand = 'npm test --',
      jestConfigFile = find_config('jest.config.ts'),
    }),
    require('neotest-vitest')({ vitestConfigFile = find_config('vitest.config.ts') }),
    require('neotest-zig')({ dap = { adapters = 'lldb-dap' } }),
    require('rustaceanvim.neotest'),
  }

  local consumers = {}
  consumers.trouble = function(client)
    client.listeners.results = function(adapter_id, results, partial)
      if partial then return end
      local tree = assert(client:get_position(nil, { adapter = adapter_id }))
      local failed = 0
      for pos_id, result in pairs(results) do
        if result.status == 'failed' and tree:get_key(pos_id) then failed = failed + 1 end
      end
      vim.schedule(function()
        local trouble = require('trouble')
        if trouble.is_open() then
          trouble.refresh()
          if failed == 0 then trouble.close() end
        end
      end)
      return {}
    end
  end

  require('neotest').setup({
    adapters = adapters,
    consumers = consumers,
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function() require('trouble').open({ mode = 'quickfix', focus = false }) end,
    },
  })
end

local function nt(fn)
  return function()
    ensure_init()
    fn()
  end
end

vim.keymap.set(
  'n',
  '<leader>ta',
  nt(function() require('neotest').run.run(vim.uv.cwd()) end),
  { desc = 'run [a]ll files' }
)
vim.keymap.set(
  'n',
  '<leader>td',
  nt(function() require('neotest').run.run({ strategy = 'dap' }) end),
  { desc = '[d]ebug nearest' }
)
vim.keymap.set(
  'n',
  '<leader>tf',
  nt(function() require('neotest').run.run(vim.fn.expand('%')) end),
  { desc = 'run [f]ile' }
)
vim.keymap.set('n', '<leader>tl', nt(function() require('neotest').run.run_last() end), { desc = 'run [l]ast' })
vim.keymap.set('n', '<leader>tr', nt(function() require('neotest').run.run() end), { desc = '[r]un nearest' })
vim.keymap.set(
  'n',
  '<leader>to',
  nt(function() require('neotest').output.open({ enter = true, auto_close = true }) end),
  { desc = 'show [o]utput' }
)
vim.keymap.set(
  'n',
  '<leader>tO',
  nt(function() require('neotest').output_panel.toggle() end),
  { desc = '[O]utput panel' }
)
vim.keymap.set('n', '<leader>ts', nt(function() require('neotest').summary.toggle() end), { desc = '[s]ummary' })
vim.keymap.set('n', '<leader>tS', nt(function() require('neotest').run.stop() end), { desc = '[S]top' })
vim.keymap.set(
  'n',
  '<leader>tw',
  nt(function() require('neotest').watch.toggle(vim.fn.expand('%')) end),
  { desc = '[w]atch' }
)
