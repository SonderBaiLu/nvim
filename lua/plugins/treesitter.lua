-- =============================================================================
-- plugins/treesitter.lua — Neovim 0.12 使用 nvim-treesitter main（master 已归档）
-- 插件目录不存在时自动跳过，避免网络失败导致启动卡死
-- =============================================================================

local ensure_installed = {
  "bash",
  "c",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "regex",
  "rust",
  "scss",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "yaml",
}

local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
local ts_installed = vim.uv.fs_stat(ts_path) ~= nil

if not ts_installed then
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
      vim.notify(
        "nvim-treesitter 尚未安装。网络可用时执行 :Lazy sync，再 :TSInstall markdown markdown_inline",
        vim.log.levels.WARN,
        { title = "Treesitter" }
      )
    end,
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    enabled = ts_installed,
    lazy = false,
    priority = 80,
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter")
      if not ok then
        return
      end

      pcall(ts.setup, {
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- 仅安装缺失解析器，避免每次启动重复下载
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          if type(ts.install) ~= "function" then
            return
          end
          local installed = {}
          if type(ts.get_installed) == "function" then
            for _, lang in ipairs(ts.get_installed()) do
              installed[lang] = true
            end
          end
          local missing = {}
          for _, lang in ipairs(ensure_installed) do
            if not installed[lang] then
              table.insert(missing, lang)
            end
          end
          if #missing > 0 then
            pcall(ts.install, missing)
          end
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("STreesitterStart", { clear = true }),
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          if ft == "" then
            return
          end
          local lang = vim.treesitter.language.get_lang(ft) or ft
          if not pcall(vim.treesitter.start, ev.buf, lang) then
            return
          end
          pcall(function()
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    enabled = ts_installed,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      pcall(function()
        require("nvim-treesitter-textobjects").setup({
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]f"] = "@function.outer" },
            goto_previous_start = { ["[f"] = "@function.outer" },
          },
        })
      end)
    end,
  },
}
