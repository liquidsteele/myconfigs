-- Resolve o interpretador Python correcto para o projecto do buffer actual.
--
-- Substitui o antigo `before_init` que fazia `vim.fn.finddir(".venv", cwd)` e
-- um `vim.fn.system("poetry env info")` BLOQUEANTE em cada arranque de LSP.
-- Aqui: raiz detectada por marcadores do projecto (não pelo cwd), poetry só é
-- invocado como último recurso, com timeout, e o resultado fica em cache por raiz.

local M = {}

M.root_markers = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

---@type table<string, string> raiz -> caminho do interpretador
local cache = {}

---Raiz do projecto para um buffer (fallback: cwd)
---@param bufnr integer?
---@return string
function M.root(bufnr)
  return vim.fs.root(bufnr or 0, M.root_markers) or vim.uv.cwd()
end

---Corre um comando com timeout, devolve stdout limpo ou nil
---@param cmd string[]
---@param cwd string
---@return string?
local function run(cmd, cwd)
  if vim.fn.executable(cmd[1]) ~= 1 then
    return nil
  end
  local ok, res = pcall(function()
    return vim.system(cmd, { cwd = cwd, text = true }):wait(3000)
  end)
  if not ok or not res or res.code ~= 0 then
    return nil
  end
  local out = vim.trim(res.stdout or "")
  return out ~= "" and out or nil
end

---Caminho do interpretador Python para a raiz dada.
---@param root string?
---@return string
function M.path(root)
  root = root or M.root()
  if cache[root] then
    return cache[root]
  end

  local found

  -- 1. venv já activo na shell que lançou o nvim (uv run, direnv, activate...)
  local active = vim.env.VIRTUAL_ENV
  if active and active ~= "" then
    local p = active .. "/bin/python"
    if vim.uv.fs_stat(p) then
      found = p
    end
  end

  -- 2. venv dentro da árvore do projecto (uv, python -m venv, poetry in-project)
  if not found then
    for _, dir in ipairs({ ".venv", "venv", ".env" }) do
      local p = root .. "/" .. dir .. "/bin/python"
      if vim.uv.fs_stat(p) then
        found = p
        break
      end
    end
  end

  -- 3. poetry com venv fora da árvore (o caso do janus)
  if not found and vim.uv.fs_stat(root .. "/pyproject.toml") then
    local p = run({ "poetry", "env", "info", "--executable" }, root)
    if p and vim.uv.fs_stat(p) then
      found = p
    end
  end

  -- 4. desistir: python do sistema
  found = found or vim.fn.exepath("python3")

  cache[root] = found
  return found
end

---Esquecer a cache (usar depois de criar um venv novo)
function M.clear()
  cache = {}
end

return M
