vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = vim.keymap.set
local opts = { silent = true }

-- =============================================================================
-- 1. 基础与日常核心（10 个）
-- =============================================================================
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "保存当前文件" })
map("n", "<Leader>w", "<cmd>w<cr>", { desc = "保存文件" })
map("n", "<Leader>q", "<cmd>q<cr>", { desc = "退出当前窗口" })
map("n", "<Leader>Q", "<cmd>qa!<cr>", { desc = "强制退出所有 (不保存)" })
map("n", "<Leader>nh", "<cmd>nohlsearch<cr>", { desc = "清除搜索高亮" })
-- 插入模式下的高频光标微调
map("i", "<A-h>", "<Left>", { desc = "光标向Left微调" })
map("i", "<A-l>", "<Right>", { desc = "光标向Right微调" })
map("i", "<A-j>", "<Down>", { desc = "光标向Down微调" })
map("i", "<A-k>", "<Up>", { desc = "光标向Up微调" })
-- 视觉模式下允许连续缩进
map("v", "<", "<gv", { desc = "减少缩进" })
map("v", ">", ">gv", { desc = "增加缩进" })

-- =============================================================================
-- 2. 窗口分屏与控制（8 个）
-- =============================================================================
map("n", "<Leader>w-", "<cmd>split<cr>", { desc = "横向分屏" })
map("n", "<Leader>w|", "<cmd>vsplit<cr>", { desc = "纵向分屏" })
map("n", "<Leader>wd", "<C-w>c", { desc = "关闭当前分屏" })
map("n", "<Leader>wo", "<C-w>o", { desc = "关闭其余所有分屏" })
-- 极速在分屏之间穿梭 (用 Leader + 方向，或者如果你习惯 Ctrl + hjkl 也可在此映射)
map("n", "<C-h>", "<C-w>h", { desc = "跳到左侧分屏" })
map("n", "<C-l>", "<C-w>l", { desc = "跳到右侧分屏" })
map("n", "<C-j>", "<C-w>j", { desc = "跳到下侧分屏" })
map("n", "<C-k>", "<C-w>k", { desc = "跳到上侧分屏" })

-- =============================================================================
-- 3. 标签页与缓冲区 (Buffer) 管理（8 个）
-- =============================================================================
map("n", "<C-o>", function() require("astrocore.buffer").nav(vim.v.count1) end, { desc = "下一个标签页" }) -- 兼容老习惯
map("n", "<C-i>", function() require("astrocore.buffer").nav(-vim.v.count1) end, { desc = "上一个标签页" })
map("n", "<Leader>bb", "<cmd>buffers<cr>", { desc = "列出所有缓冲区" })
map("n", "<Leader>bn", "<cmd>bnext<cr>", { desc = "下一个标签" })
map("n", "<Leader>bp", "<cmd>bprevious<cr>", { desc = "上一个标签" })
map("n", "<Leader>bc", "<cmd>bdelete<cr>", { desc = "关闭当前标签" })
map("n", "<Leader>bC", "<cmd>%bd|e#|bd#<cr>", { desc = "关闭除当前外所有标签" })
map("n", "<Leader>ba", "<cmd>ball<cr>", { desc = "展开所有标签" })

-- =============================================================================
-- 4. 文件树 Neo-Tree 专属按键（4 个）
-- =============================================================================
map("n", "<Leader>e", "<cmd>Neotree toggle<cr>", { desc = "资源管理器 (侧边栏)" })
map("n", "<Leader>fe", "<cmd>Neotree focus<cr>", { desc = "聚焦到资源管理器" })
map("n", "<Leader>go", "<cmd>Neotree git_status<cr>", { desc = "打开 Git 变更树" })
map("n", "<Leader>bo", "<cmd>Neotree buffers<cr>", { desc = "打开活动缓冲区树" })

-- =============================================================================
-- 5. 全局模糊查找与高级重构 (对接 Grug-Far 与 Todo-Comments)（10 个）
-- =============================================================================
-- 重构神器 Grug-Far
map("n", "<Leader>fr", "<cmd>GrugFar<cr>", { desc = "重构：全局结构化物理替换 (IDEA 同款)" })
-- 代办事项工具 Todo-Comments
map("n", "<Leader>ft", "<cmd>TodoTelescope<cr>", { desc = "查找：全局项目 TODO 待办" })
map("n", "<Leader>xt", "<cmd>TodoTrouble<cr>", { desc = "面板：项目待办事项列表" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "跳转：下一个 TODO" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "跳转：上一个 TODO" })
-- 顺便把 LSP 全局查找占位符准备好
map("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { desc = "查找：文件名" })
map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "查找：全文文本线索" })
map("n", "<Leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "查找：最近打开的历史文件" })
map("n", "<Leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "查找：实时查询快捷键" })
map("n", "<Leader>fC", "<cmd>Telescope commands<cr>", { desc = "查找：Neovim 历史命令" })

-- =============================================================================
-- 6. 高维闪现与运动 (Flash.nvim)（4 个）
-- =============================================================================
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "运动：全屏高维视觉跳跃" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "运动：基于 AST 语义块选择" })
map("o", "r", function() require("flash").remote() end, { desc = "运动：远程动作触发器" })
map({ "x", "o" }, "R", function() require("flash").treesitter_search() end, { desc = "运动：语义正规搜索" })

-- =============================================================================
-- 7. 数据库 UI (Vim-Dadbod) 与 插件包管理面板（6 个）
-- =============================================================================
map("n", "<Leader>D", "<cmd>DBUIToggle<cr>", { desc = "数据库：切换侧边数据面板" })
map("n", "<Leader>Dc", "<cmd>DBUIAddConnection<cr>", { desc = "数据库：添加新连接" })
map("n", "<Leader>Df", "<cmd>DBUIFindBuffer<cr>", { desc = "数据库：定位当前 SQL 文件" })
map("n", "<Leader>Dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "数据库：重命名 SQL 缓存" })
-- 包管理器快捷打开
map("n", "<Leader>pl", "<cmd>Lazy<cr>", { desc = "管理：打开 Lazy 插件管理面板" })
map("n", "<Leader>pm", "<cmd>Mason<cr>", { desc = "管理：打开 Mason 工具下载面板" })

-- =============================================================================
-- 8. AI 补全手动唤醒 (Minuet-AI) 与 系统中文输入切换（2 个）
-- =============================================================================
map("i", "<A-i>", function() require("minuet.virtualtext.action").invoke() end, { desc = "手动召唤 AI 补全" })
map("n", "<Leader>li", "<cmd>Fcitx2Eng<cr>", { desc = "系统：强制输入法降档为英文" })

-- =============================================================================
-- 9. LSP 核心编码与语义制导（7 个）
-- =============================================================================
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: 跳转到定义" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: 跳转到声明" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: 跳转到实现" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP: 查找全局引用" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP: 悬浮文档提示" })
map("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "LSP: 修复与代码动作" })
map("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "LSP: 重命名当前变量" })
