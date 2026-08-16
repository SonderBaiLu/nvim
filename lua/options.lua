-- =============================================================================
-- options.lua — 编辑器基础选项与跨平台环境（关联 S.lua）
-- =============================================================================

local S = require("S")

-- Leader 必须在插件加载前设置
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- 禁用内置 netrw（由 neo-tree 接管，提升启动速度）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

S.setup_path()
S.setup_clipboard()

local opt = vim.opt

-- 外观
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false -- 由 lualine 显示模式（中文）
opt.laststatus = 3 -- 全局状态栏
opt.cmdheight = 0 -- 与 noice 协同，减少命令行占用
opt.pumheight = 12
opt.scrolloff = 6
opt.sidescrolloff = 8
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", fold = " ", foldopen = "▾", foldclose = "▸" }

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.breakindent = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- 性能与体验
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true
opt.smoothscroll = true

-- 折叠（Treesitter；无解析器时安全回退）
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
-- 无 treesitter 时避免报错刷屏
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("SFoldFallback", { clear = true }),
  callback = function(ev)
    local ok = pcall(vim.treesitter.get_parser, ev.buf)
    if not ok then
      vim.wo.foldmethod = "indent"
    end
  end,
})

-- Windows 终端兼容：减少闪烁
if S.is_windows then
  opt.shellslash = false
end
