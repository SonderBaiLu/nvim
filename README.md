# 纯原生 Neovim 全栈开发配置

完全独立的 Lua 配置（**无 AstroNvim**），面向 Linux / Windows / WSL，统一 Catppuccin Mocha 视觉与中文界面。

## 特性概览

- 插件管理：`lazy.nvim`（默认懒加载 + `:Lazy profile` 启动分析）
- 补全：`blink.cmp` + LuaSnip（不使用 nvim-cmp）
- LSP：Mason 自动安装，覆盖 Rust / Lua / TS / Vue / React / HTML / CSS / SQL / Markdown
- 格式化：`conform.nvim`（保存时自动格式化）
- Lint：`nvim-lint`（ESLint）；Rust Clippy 经 rust-analyzer
- 调试：`nvim-dap`（codelldb + js-debug-adapter）
- UI：Catppuccin · lualine · bufferline · neo-tree · snacks dashboard · noice

## 目录结构

```text
nvim/
├── init.lua                 # 入口
├── lua/
│   ├── S.lua                # 跨平台工具库
│   ├── options.lua          # 编辑器选项
│   ├── keymaps.lua          # 全局快捷键
│   ├── autocmds.lua         # 自动保存等
│   ├── lazy_init.lua        # lazy.nvim 引导
│   └── plugins/             # 单一职责插件模块（均 < 300 行）
│       ├── colorscheme.lua
│       ├── lualine.lua
│       ├── bufferline.lua
│       ├── neo-tree.lua
│       ├── snacks.lua
│       ├── ui.lua
│       ├── hlchunk.lua
│       ├── rainbow.lua
│       ├── blink.lua
│       ├── mason.lua
│       ├── lsp.lua
│       ├── formatting.lua
│       ├── lint.lua
│       ├── comment.lua
│       ├── autopairs.lua
│       ├── session.lua
│       ├── flash.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       ├── gitsigns.lua
│       ├── lazygit.lua
│       ├── markdown.lua
│       ├── database.lua
│       ├── toggleterm.lua
│       ├── overseer.lua
│       ├── dap.lua
│       ├── which-key.lua
│       └── frontend.lua
├── lazy-lock.json           # 首次 :Lazy sync 后生成/更新
└── README.md
```

## 安装步骤

### 通用前置依赖

| 依赖 | 说明 |
|------|------|
| Neovim **0.10+**（推荐 0.11+） | `vim.lsp.config` API |
| Git | 克隆插件 |
| [Nerd Font](https://www.nerdfonts.com/) | 推荐 **Sarasa Term SC Nerd** / JetBrainsMono Nerd Font |
| ripgrep (`rg`) | Telescope 全文搜索 |
| fd | 可选，加速找文件 |
| Node.js 18+ | TS/Vue LSP、Prettier、Markdown 预览 |
| Rust toolchain | `rust-analyzer`、`rustfmt`、`clippy` |
| tree-sitter CLI（可选） | 部分环境编译解析器需要 |

### Linux

```bash
# 备份旧配置
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# 链接或复制本仓库
git clone <你的仓库地址> ~/.config/nvim
# 或: ln -s /path/to/nvbim/nvim ~/.config/nvim

# 系统依赖示例（Debian/Ubuntu）
sudo apt install ripgrep fd-find
# Arch: sudo pacman -S ripgrep fd

nvim
# 首次启动会自动安装 lazy.nvim 与插件，完成后执行：
:Lazy sync
:Mason
# 在 Mason 中确认 LSP/工具已安装，或等待 mason-tool-installer 自动安装
```

### Windows

```powershell
# 备份
Move-Item $env:LOCALAPPDATA\nvim "$env:LOCALAPPDATA\nvim.bak" -ErrorAction SilentlyContinue

# 复制或克隆到
# %LOCALAPPDATA%\nvim
git clone <你的仓库地址> "$env:LOCALAPPDATA\nvim"

# 建议安装
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install OpenJS.NodeJS.LTS
winget install Rustlang.Rustup

# 终端字体设为 Sarasa Term SC Nerd 或 JetBrainsMono Nerd Font
nvim
:Lazy sync
```

### WSL

在 WSL 内按 Linux 方式安装配置；剪贴板已在 `S.setup_clipboard()` 中对接 `clip.exe`。

## 语言工具链

| 语言 | LSP | 格式化 | Lint / 调试 |
|------|-----|--------|-------------|
| Lua | lua_ls | stylua | — |
| Rust | rust-analyzer | rustfmt | Clippy / codelldb |
| JS/TS/React | vtsls | prettier | eslint_d / js-debug |
| Vue 3 | vue_ls + vtsls 插件 | prettier | eslint_d |
| HTML/CSS/SCSS | html / cssls / emmet | prettier | stylelint（可选） |
| Markdown | marksman | prettier | 浏览器预览 |
| PostgreSQL | —（dadbod 补全） | sql-formatter | dadbod-ui |

> Windows 说明：`sqls` 需要 Go，`sqlls` 需要编译原生模块，故默认不自动安装 SQL LSP；数据库开发以 `vim-dadbod` + `vim-dadbod-ui` + blink 补全为准。若已安装 Go，可在 Mason 中手动安装 `sqls` 并在 `lsp.lua` 中加回配置。

## 主要快捷键

Leader = `空格`

### 文件与搜索

| 快捷键 | 功能 |
|--------|------|
| `<Leader>e` | 切换资源管理器 |
| `<Leader>ff` | 查找文件 |
| `<Leader>fg` | 全文搜索 |
| `<Leader>fo` | 最近文件 |
| `<Leader>fb` | 缓冲区列表 |

### LSP / 代码

| 快捷键 | 功能 |
|--------|------|
| `gd` / `gD` / `gr` / `gi` | 定义 / 声明 / 引用 / 实现 |
| `K` | 悬浮文档 |
| `<Leader>ca` | 代码动作 |
| `<Leader>cr` | 重命名 |
| `<Leader>cf` | 格式化 |
| `<Leader>cl` | 手动 Lint |
| `gl` / `]d` / `[d` | 诊断详情 / 下一个 / 上一个 |
| `<Leader>xx` | Trouble 诊断面板 |

### Git / 终端 / 调试

| 快捷键 | 功能 |
|--------|------|
| `<Leader>gg` | LazyGit |
| `]h` / `[h` | 下一个/上一个 Git 块 |
| `<C-\>` | 浮动终端 |
| `<Leader>db` | 切换断点 |
| `<Leader>dc` | 继续/启动调试 |
| `<Leader>du` | 调试 UI |

### 数据库（前缀 `k` = 库，避开与调试 `d` 冲突）

| 快捷键 | 功能 |
|--------|------|
| `<Leader>ku` | 切换数据库面板 |
| `<Leader>kc` | 添加数据库连接 |
| `<Leader>kf` | 定位 SQL 缓冲 |

### 其他

| 快捷键 | 功能 |
|--------|------|
| `s` / `S` | Flash 跳转 / 语法树选择 |
| `<Leader>mp` | Markdown 预览 |
| `<Leader>or` | Overseer 运行任务 |
| `<Leader>pp` | Lazy 启动性能分析 |
| `<Leader>ss` / `<Leader>sl` | 保存 / 加载会话 |
| `<C-s>` | 保存 |
| `<C-o>` / `<C-i>` | 下一个 / 上一个标签 |

完整分组提示：按 `<Leader>` 后稍候，由 which-key 以中文显示。

## 性能

- 默认 `lazy = true`，按 `event` / `cmd` / `ft` / `keys` 加载
- 已禁用 netrw、gzip、tar、zip 等内置插件
- 自检：启动后执行 `:Lazy profile`，目标参考机（i7-10 代 + SSD）≤ 150ms（机器差异可浮动）

## 常见问题

### LSP 未启动

1. `:LspInfo` 查看是否附加
2. `:Mason` 确认对应服务器已安装
3. Vue：确认 `vue-language-server` 与 `vtsls` 均已安装；`.vue` 需两者配合
4. 工作区根目录需有项目标记（如 `package.json`、`Cargo.toml`）

### 格式化失败

1. `:ConformInfo` 查看可用 formatter
2. 确认 Mason 已装 `prettier` / `stylua` / `sql-formatter`
3. Rust 需系统 `rustfmt`（`rustup component add rustfmt`）

### ESLint 无输出

项目需存在 ESLint 配置文件；无配置时会静默跳过，避免刷屏。

### Windows 终端图标乱码

将终端字体改为 Nerd Font（推荐 Sarasa Term SC Nerd），并确保 `termguicolors` 开启。

### 启动偏慢

`:Lazy profile` 找出耗时插件；避免在 `init` 阶段同步安装大量 Treesitter 解析器（首次会较慢，之后有缓存）。

### 数据库连接

编辑 `lua/plugins/database.lua` 中 `vim.g.dbs` 示例连接，或在 UI 中用 `<Leader>kc` 添加。连接串勿提交真实密码到公开仓库。

## 版本锁定

首次在本机执行：

```vim
:Lazy sync
```

将自动生成/更新 `lazy-lock.json`，提交该文件即可跨机器复现插件版本。

## 迁移说明（相对旧配置）

已删除/替换：

| 旧内容 | 原因 |
|--------|------|
| AstroNvim / `astrocore` 键位 | 彻底去框架化 |
| `dankcolors.lua` | 与 Catppuccin 冲突 |
| `barbar.lua` | 换用 bufferline |
| `cmp-enhance` / Minuet | 统一 blink.cmp |
| `dropbar` / `grug_far` / `todo` 等 | 非验收必需，降低启动面 |

配置为从零重写的原生模块，可直接覆盖使用。
