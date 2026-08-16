-- =============================================================================
-- autocmds.lua — 自动命令（自动保存、 yank 高亮、窗口自适应等）
-- =============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 复制后短暂高亮
autocmd("TextYankPost", {
  group = augroup("SYankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 180 })
  end,
})

-- 自动保存：离开插入模式 / 离开缓冲区时写入（跳过特殊 buftype）
autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
  group = augroup("SAutoSave", { clear = true }),
  callback = function(args)
    local buf = args.buf
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable or not vim.bo[buf].modified then
      return
    end
    if vim.bo[buf].readonly then
      return
    end
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
      return
    end
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
  end,
})

-- 打开文件时恢复上次光标位置
autocmd("BufReadPost", {
  group = augroup("SLastLoc", { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 窗口尺寸变化时均衡分屏
autocmd("VimResized", {
  group = augroup("SResize", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- 终端缓冲区：无行号、进入时自动插入
autocmd("TermOpen", {
  group = augroup("STerm", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- 关闭部分文件类型的自动注释延续
autocmd("FileType", {
  group = augroup("SFormatOptions", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
