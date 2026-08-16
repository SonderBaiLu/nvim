-- =============================================================================
-- keymaps.lua — 全局快捷键（与 which-key 分组对齐）
-- 约定：
--   <Leader>d* = 调试（dap）
--   <Leader>k* = 数据库（dadbod）— 禁止再用 D，避免与 d 混淆
--   <Leader>w* = 窗口；保存用 <C-s> / <Leader>ws
-- =============================================================================

local S = require("S")
local map = S.map

-- -----------------------------------------------------------------------------
-- 基础编辑
-- -----------------------------------------------------------------------------
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", "保存文件")
map("n", "<Leader>q", "<cmd>q<cr>", "退出窗口")
map("n", "<Leader>Q", "<cmd>qa!<cr>", "强制退出全部")
map("n", "<Leader>uc", "<cmd>nohlsearch<cr>", "清除搜索高亮")

map("i", "<A-h>", "<Left>", "插入：光标左移")
map("i", "<A-l>", "<Right>", "插入：光标右移")
map("i", "<A-j>", "<Down>", "插入：光标下移")
map("i", "<A-k>", "<Up>", "插入：光标上移")

map("v", "<", "<gv", "减少缩进并保持选区")
map("v", ">", ">gv", "增加缩进并保持选区")
map("n", "j", "gj", "按显示行下移")
map("n", "k", "gk", "按显示行上移")

-- -----------------------------------------------------------------------------
-- 窗口（<Leader>w）
-- -----------------------------------------------------------------------------
map("n", "<Leader>w-", "<cmd>split<cr>", "横向分屏")
map("n", "<Leader>w|", "<cmd>vsplit<cr>", "纵向分屏")
map("n", "<Leader>wd", "<C-w>c", "关闭当前分屏")
map("n", "<Leader>wo", "<C-w>o", "只保留当前分屏")
map("n", "<Leader>ww", "<C-w>w", "切换到下一窗口")
map("n", "<Leader>wh", "<C-w>h", "聚焦左侧窗口")
map("n", "<Leader>wj", "<C-w>j", "聚焦下方窗口")
map("n", "<Leader>wk", "<C-w>k", "聚焦上方窗口")
map("n", "<Leader>wl", "<C-w>l", "聚焦右侧窗口")
map("n", "<Leader>ws", "<cmd>w<cr>", "保存当前文件")

map("n", "<C-h>", "<C-w>h", "聚焦左侧窗口")
map("n", "<C-l>", "<C-w>l", "聚焦右侧窗口")
map("n", "<C-j>", "<C-w>j", "聚焦下方窗口")
map("n", "<C-k>", "<C-w>k", "聚焦上方窗口")

-- -----------------------------------------------------------------------------
-- 缓冲区（<Leader>b）
-- -----------------------------------------------------------------------------
map("n", "<C-o>", "<cmd>BufferLineCycleNext<cr>", "下一个标签")
map("n", "<C-i>", "<cmd>BufferLineCyclePrev<cr>", "上一个标签")
map("n", "<Leader>bn", "<cmd>bnext<cr>", "下一个缓冲区")
map("n", "<Leader>bp", "<cmd>bprevious<cr>", "上一个缓冲区")
map("n", "<Leader>bc", "<cmd>bdelete<cr>", "关闭当前缓冲区")
map("n", "<Leader>bC", "<cmd>%bd|e#|bd#<cr>", "关闭其他缓冲区")
map("n", "<Leader>bb", "<cmd>buffers<cr>", "列出缓冲区")
map("n", "<Leader>bo", "<cmd>Neotree buffers<cr>", "缓冲区树")

-- -----------------------------------------------------------------------------
-- 文件树 / 查找（<Leader>f）
-- -----------------------------------------------------------------------------
map("n", "<Leader>e", "<cmd>Neotree toggle<cr>", "资源管理器")
map("n", "<Leader>fe", "<cmd>Neotree focus<cr>", "聚焦资源管理器")
map("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", "查找文件")
map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", "全文搜索")
map("n", "<Leader>fo", "<cmd>Telescope oldfiles<cr>", "最近文件")
map("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", "查找缓冲区")
map("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", "帮助文档")
map("n", "<Leader>fk", "<cmd>Telescope keymaps<cr>", "查找快捷键")
map("n", "<Leader>fc", "<cmd>Telescope commands<cr>", "查找命令")
map("n", "<Leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", "文档符号")
map("n", "<Leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", "工作区符号")

-- -----------------------------------------------------------------------------
-- Git（<Leader>g）
-- -----------------------------------------------------------------------------
map("n", "<Leader>go", "<cmd>Neotree git_status<cr>", "Git 变更树")

-- -----------------------------------------------------------------------------
-- LSP / 代码（<Leader>c）
-- -----------------------------------------------------------------------------
map("n", "gd", vim.lsp.buf.definition, "跳转到定义")
map("n", "gD", vim.lsp.buf.declaration, "跳转到声明")
map("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
map("n", "gr", vim.lsp.buf.references, "查找引用")
map("n", "gt", vim.lsp.buf.type_definition, "跳转到类型定义")
map("n", "K", vim.lsp.buf.hover, "悬浮文档")
map("n", "<Leader>ca", vim.lsp.buf.code_action, "代码动作")
map("n", "<Leader>cr", vim.lsp.buf.rename, "重命名符号")
map("n", "gl", vim.diagnostic.open_float, "行内诊断详情")
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, "上一个诊断")
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, "下一个诊断")
map("n", "<Leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, "格式化缓冲区")

-- 数据库快捷键仅在 plugins/database.lua（<Leader>k*），此处不重复

-- -----------------------------------------------------------------------------
-- 插件管理（<Leader>p）
-- -----------------------------------------------------------------------------
map("n", "<Leader>pl", "<cmd>Lazy<cr>", "Lazy 插件管理")
map("n", "<Leader>pp", "<cmd>Lazy profile<cr>", "启动性能分析")
map("n", "<Leader>pm", "<cmd>Mason<cr>", "Mason 工具管理")
