-- =============================================================================
-- S.lua — 全局工具函数库（系统检测 / 路径 / 剪贴板 / LSP 辅助）
-- 使用方式：require("S") 后通过 _G.S 或返回值调用
-- =============================================================================

local S = {}

--- 是否为 Windows（含原生 Win32，不含仅 WSL）
S.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

--- 是否为 Linux
S.is_linux = vim.fn.has("unix") == 1 and not S.is_windows

--- 是否在 WSL 中运行
S.is_wsl = (function()
  if S.is_windows then
    return false
  end
  local ok, release = pcall(vim.fn.system, { "uname", "-r" })
  if not ok or type(release) ~= "string" then
    return false
  end
  return release:lower():find("microsoft", 1, true) ~= nil
end)()

--- 当前系统路径分隔符（PATH 用）
S.path_sep = S.is_windows and ";" or ":"

--- 文件系统路径分隔符
S.fs_sep = S.is_windows and "\\" or "/"

--- 规范化路径：展开 ~，并按 OS 统一斜杠
---@param path string
---@return string
function S.normalize_path(path)
  local expanded = vim.fn.expand(path)
  if S.is_windows then
    return expanded:gsub("/", "\\")
  end
  return expanded:gsub("\\", "/")
end

--- 安全拼接路径（基于 vim.fs.joinpath，兼容跨平台）
---@param ... string
---@return string
function S.join(...)
  return S.normalize_path(vim.fs.joinpath(...))
end

--- 标准路径快捷方式
function S.config_path(...)
  return S.join(vim.fn.stdpath("config"), ...)
end

function S.data_path(...)
  return S.join(vim.fn.stdpath("data"), ...)
end

function S.cache_path(...)
  return S.join(vim.fn.stdpath("cache"), ...)
end

--- 若目录存在则追加到 PATH
---@param path string
function S.prepend_path(path)
  path = S.normalize_path(path)
  if vim.fn.isdirectory(path) == 1 then
    vim.env.PATH = path .. S.path_sep .. (vim.env.PATH or "")
  end
end

--- 注入常见工具目录到 PATH（Mason / Cargo / npm）
function S.setup_path()
  S.prepend_path(S.data_path("mason", "bin"))
  S.prepend_path(S.normalize_path("~/.cargo/bin"))
  if S.is_windows then
    S.prepend_path(S.normalize_path("~/AppData/Roaming/npm"))
  else
    S.prepend_path(S.normalize_path("~/.npm-global/bin"))
    S.prepend_path(S.normalize_path("~/.local/share/pnpm"))
    S.prepend_path(S.normalize_path("~/.local/bin"))
  end
end

--- 配置系统剪贴板（Windows / WSL / Linux 兼容）
function S.setup_clipboard()
  vim.opt.clipboard = "unnamedplus"
  if S.is_wsl then
    -- WSL：优先 clip.exe / powershell；若已安装 win32yank 亦可
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
      },
      paste = {
        ["+"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
        ["*"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
      },
      cache_enabled = 0,
    }
  end
end

--- 获取当前 buffer 已附加的 LSP 客户端名称列表
---@param bufnr? integer
---@return string[]
function S.lsp_client_names(bufnr)
  bufnr = bufnr or 0
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    table.insert(names, client.name)
  end
  return names
end

--- 安全 keymap 封装
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param opts? table
function S.map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false
  if desc then
    opts.desc = desc
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

_G.S = S
return S
