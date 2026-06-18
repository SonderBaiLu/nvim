---@diagnostic disable: undefined-global
-- =============================================================================
--                 1. 跨平台核心环境变量与工具路径动态注入
-- =============================================================================
local is_windows = vim.fn.has "win32" == 1
local path_sep = is_windows and ";" or ":"

-- 统一路径格式化函数：智能展开波浪号并根据 OS 转换斜杠方向
local function normalize_path(path)
  local expanded = vim.fn.expand(path)
  if is_windows then
    return expanded:gsub("/", "\\")
  else
    return expanded
  end
end

-- 动态计算并注入 Mason 二进制下载目录
local mason_bin = normalize_path(vim.fn.stdpath "data" .. "/mason/bin")
vim.env.PATH = mason_bin .. path_sep .. vim.env.PATH

local extra_paths = {}

if is_windows then
  -- Windows 阵营专属路径
  table.insert(extra_paths, normalize_path "~/.cargo/bin")
  table.insert(extra_paths, normalize_path "~/AppData/Roaming/npm")
else
  -- Linux / macOS 阵营专属路径
  table.insert(extra_paths, normalize_path "~/.cargo/bin")
  table.insert(extra_paths, normalize_path "~/.npm-global/bin")
  table.insert(extra_paths, normalize_path "~/.local/share/pnpm")
end

-- 极其安全的防御性循环：只有当该路径在当前电脑上真实存在时，才允许追加到 PATH 中
for _, path in ipairs(extra_paths) do
  if vim.fn.isdirectory(path) == 1 then vim.env.PATH = vim.env.PATH .. path_sep .. path end
end

-- =============================================================================
--                 2. 全局前缀键定义 (必须在加载任何插件前确立)
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- =============================================================================
--                 3. 原生基础 Vim 选项配置 (脱离旧框架独立运行)
-- =============================================================================
vim.opt.relativenumber = false -- 开启相对行号
vim.opt.number = true -- 显示当前行号
vim.opt.signcolumn = "yes" -- 始终显示符号列
vim.opt.wrap = true -- 长代码自动在视窗内折行
vim.opt.tabstop = 2 -- Tab 占 2 个空格
vim.opt.shiftwidth = 2 -- 缩进占 2 个空格
vim.opt.expandtab = true -- 将 Tab 自动转换为空格
vim.opt.termguicolors = true -- 开启 24 位真彩色支持
vim.opt.clipboard = "unnamedplus" -- 挂载系统剪贴板
