--[[
Root workspace utilities.
--]]

---@class util.file
local M = setmetatable({}, {
  __call = function(m) return m.get() end,
})

---@class Root
---@field paths string[]
---@field spec RootSpec

---@alias RootFn fun(buf: number): (string|string[])
---@alias RootSpec string|string[]|RootFn

---@type RootSpec[]
M.spec = { 'lsp', { '.git', 'lua' }, 'cwd' }
M.detectors = {}

---@type table<number, string>
M.cache = {}

function M.bufpath(buf) return M.realpath(vim.api.nvim_buf_get_name(assert(buf))) end

--- Get the path to the IDE configuration directory for the given path.
---@param path string|nil Path to the directory to start searching in. Defaults to the current working directory.
---@return string|nil
function M.config(path) return M.vim(path) or M.vscode(path) end

--- Detect the root directory of the current buffer.
---@param opts? { buf?: number, spec?: RootSpec[], all?: boolean }
function M.detect(opts)
  opts = opts or {}
  opts.spec = opts.spec or type(vim.g.root_spec) == 'table' and vim.g.root_spec or M.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {} ---@type Root[]
  for _, spec in ipairs(opts.spec) do
    local paths = M.resolve(spec)(opts.buf)
    paths = paths or {}
    paths = type(paths) == 'table' and paths or { paths }

    local roots = {} ---@type string[]
    for _, p in ipairs(paths) do
      local pp = M.realpath(p)
      if pp and not vim.tbl_contains(roots, pp) then roots[#roots + 1] = pp end
    end

    table.sort(roots, function(a, b) return #a > #b end)
    if #roots > 0 then
      ret[#ret + 1] = { spec = spec, paths = roots }
      if opts.all == false then break end
    end
  end
  return ret
end

--- Get the current working directory.
---@return string
function M.detectors.cwd() return { vim.uv.cwd() } end

--- Get the root directory of the current buffer based on LSP clients.
---@return string
function M.detectors.lsp(buf)
  local bufpath = M.bufpath(buf)
  if not bufpath then return {} end

  local roots = {} ---@type string[]
  local clients = require('util.lsp').get_clients({ bufnr = buf })
  clients = vim.tbl_filter(function(client) return not vim.tbl_contains({ 'copilot' }, client.name) end, clients)

  for _, client in pairs(clients) do
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
    if client.root_dir then roots[#roots + 1] = client.root_dir end
  end

  return vim.tbl_filter(function(path)
    path = require('util.path').norm(path)
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

--- Get the root directory of the current buffer based on the given patterns.
---@param patterns string[]|string
function M.detectors.pattern(buf, patterns)
  patterns = type(patterns) == 'string' and { patterns } or patterns

  local path = M.bufpath(buf) or vim.uv.cwd()
  local pattern = vim.fs.find(function(name)
    for _, p in ipairs(patterns) do
      if name == p then return true end
      if p:sub(1, 1) == '*' and name:find(vim.pesc(p:sub(2)) .. '$') then return true end
    end
    return false
  end, { path = path, upward = true })[1]

  return pattern and { vim.fs.dirname(pattern) } or {}
end

--- Returns the root directory based on:
--- * lsp workspace folders
--- * lsp root_dir
--- * root pattern of filename of the current buffer
--- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()

  local ret = M.cache[buf]
  if not ret then
    local roots = M.detect({ all = false, buf = buf })
    ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
    M.cache[buf] = ret
  end

  if opts and opts.normalize then return ret end

  return ret
end

--- Get the root directory of the current buffer
---@return string
function M.git()
  local root = M.get()
  local git_root = vim.fs.find('.git', { path = root, upward = true })[1]
  local ret = git_root and vim.fn.fnamemodify(git_root, ':h') or root
  return ret
end

function M.realpath(path)
  if path == '' or path == nil then return nil end
  path = vim.uv.fs_realpath(path) or path
  return require('util.path').norm(path)
end

---@param spec RootSpec
---@return RootFn
function M.resolve(spec)
  if M.detectors[spec] then return M.detectors[spec] end
  if type(spec) == 'function' then return spec end
  return function(buf) return M.detectors.pattern(buf, spec) end
end

--- Get the path to the Python virtual environment directory (if exists).
---@param path string|nil Path to the directory to start searching in. Defaults to the current working directory.
---@return string|nil
function M.venv(path) return require('util.dir').find('.venv', path or vim.fn.getcwd()) end

--- Get the path to the Neovim (Vim) configuration directory (if exists).
---@param path string|nil Path to the directory to start searching in. Defaults to the current working directory.
---@return string|nil
function M.vim(path) return require('util.dir').find('.vim', path or vim.fn.getcwd()) end

--- Get the path to the VS Code configuration directory (if exists).
---@param path string|nil Path to the directory to start searching in. Defaults to the current working directory.
---@return string|nil
function M.vscode(path) return require('util.dir').find('.vscode', path or vim.fn.getcwd()) end

return M
