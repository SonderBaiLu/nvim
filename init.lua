vim.g.mapleader = " "
vim.g.maplocalleader = ","
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.cargo/bin") .. ":" .. vim.fn.expand("~/.npm-global/bin")
--  引入快捷键
pcall(require, "keymaps")
-- 2. 自动安装并引导原生 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 自定 Vim 基础选项
vim.opt.relativenumber = false -- 相对行号
vim.opt.number = true -- 显示当前行号
vim.opt.signcolumn = "yes" -- 始终显示符号列
vim.opt.wrap = true -- 自动折行
vim.opt.tabstop = 2 -- Tab 占 2 空格
vim.opt.shiftwidth = 2 -- 缩进 2 空格

-- 4. 自定义你的基础快捷键映射
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "保存文件" })
vim.keymap.set("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "保存文件" })
-- 插入模式下的光标微调
vim.keymap.set("i", "<A-h>", "<Left>")
vim.keymap.set("i", "<A-l>", "<Right>")
vim.keymap.set("i", "<A-j>", "<Down>")
vim.keymap.set("i", "<A-k>", "<Up>")

-- 纯净加载 lua/plugins/ 目录下的所有独立插件配置
require("lazy").setup {
  spec = {
    { import = "plugins" }, -- 自动导入你留在 lua/plugins/ 下的所有独立插件
  },
  install = {
    -- 设置主题
    colorscheme = { "catppuccin" },
  },
  ui = {
    border = "rounded",
  },
}
-- 在 lazy 载入完成后，真正 catppuccin 主题
vim.cmd.colorscheme "catppuccin"
