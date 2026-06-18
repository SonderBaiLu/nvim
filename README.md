# 前置条件
1. lsp 需要调用`tree-sitter-cli` 系统里面需要安装这个包
# 📂 职责分明的模块化目录架构

```text
~/.config/nvim/
├── init.lua                # 内核引导启动程序，初始化 lazy.nvim
├── lua/
│   ├── lazy_setup.lua      # 插件总线加载网络（统筹社区包与自研包）
│   ├── community.lua       # 全栈语言生态底座（Rust, Vue, TS, Lua, HTML/CSS 核心增强）
│   ├── polish.lua          # 系统级生命周期后置钩子（Wayland 剪贴板内核硬核绑定）
│   └── plugins/            # 自研功能职责模块（单一职责拆解）
│       ├── astrocore.lua   # 编辑器核心选项重载、高频全局基础键位控制流
│       ├── astroui.lua     # 视觉图层高亮重写、全景浮窗透明规则引擎
│       ├── catppuccin.lua  # Catppuccin 现代质感色彩规范、防闪烁浮窗底色锁
│       ├── astrolsp.lua    # LSP（语言服务器协议）生命周期流、保存全自动格式化、意图分发
│       ├── frontend.lua    # 前端 HTML/Vue 标签同步闭合与 AST 语义重构变换
│       ├── none-ls.lua     # 物理级格式化桥接器（Prettier & StyLua 注入总线）
│       ├── database.lua    # Dadbod 可视化 PostgreSQL 关系型数据库全栈操纵矩阵
│       ├── cmp-enhance.lua # Blink.cmp 毫秒级补全高辨识度几何图标增强与高频防抖
│       ├── minuet.lua      # Minuet AI 离线/云端双大模型本地大上下文心流补全器
│       ├── neo-tree.lua    # 模块化文件拓扑树（集成隐藏配置文件与 .env 临时透视）
│       ├── noice.lua       # 内核级交互 UI 重载、居中毛玻璃命令面板流
│       ├── fcitx5.lua      # 物理输入法插入/普通模态状态机智能切换软链接
│       ├── dropbar.lua     # 基于 AST 抽象语法树的面包屑顶层路径导航
│       # ---- IDE 骨灰级能力增强积木 ----
│       ├── neotest.lua     # 可视化单元测试生命周期调度中心（Cargo test / Vitest）
│       ├── search_everywhere.lua # 全局增量索引矩阵与“Search Everywhere”搜索中心
│       ├── git_enhanced.lua # 行级版本控制差分流与 Inline Blame 虚拟文本责问追踪器
│       ├── structure_panel.lua # AST 语法大纲视图面板（IntelliJ Structure）
│       ├── treesj.lua      # 语法树级别代码块单行/多行结构化无损变换模块
│       ├── dressing.lua    # 运行时全局交互 UI（Select/Input）悬浮窗重定向
│       ├── inc_rename.lua  # LSP 符号重构全缓冲区毫秒级动态增量渲染器
│       ├── hlchunk.lua     # 作用域缩进阶梯矩阵高亮与嵌套作用域流式引导线
│       ├── sticky_context.lua # 顶层作用域粘性固定层（Sticky Lines Context）
│       ├── flash_motion.lua # 全屏幕二维字符拓扑高维视觉制导跳跃矩阵
│       └── grug_far.lua    # 项目级跨文件结构化增量正则查找/替换工作台
└── lazy-lock.json          # 全量插件原子级 Commit 锁版本编排清单
```

# 1. 普通模式下的全局控制、搜索与重构 (Normal Mode)

| 快捷键             | 功能说明                                    | 触发源插件 / 功能职责      | 联动插件或特性                        |
| ------------------ | ------------------------------------------- | -------------------------- | ------------------------------------- |
| `<Leader><Leader>` | Search Everywhere 全局模糊检索一切          | snacks.picker / 搜索中心   | 完美复刻 IDEA 双击 Shift              |
| `<Leader>ff`       | 查找文件 (根据文件名物理检索)               | snacks.picker / 文件定位   | 对应 IDEA Ctrl+Shift+N                |
| `<Leader>fg`       | 全局文本流搜索 (根据关键字实时 Grep)        | snacks.picker / 文本检索   | 对应 IDEA Ctrl+Shift+F                |
| `<Leader>fr`       | 最近打开文件历史 (文件缓冲区历史追踪)       | snacks.picker / 历史溯源   | 对应 IDEA Ctrl+E                      |
| `gd`               | 跳转至符号定义绝对坐标                      | Native LSP / 语义解析      | 联动 snacks.picker 悬浮预览           |
| `gr`               | 溯源所有引用拓扑节点 (查找所有被调用的地方) | Native LSP / 语义解析      | 对应 IDEA Alt+F7                      |
| `gD`               | 跳转至符号的声明处 (Declaration)            | Native LSP / 语义解析      | 标准 LSP 规范                         |
| `<Leader>lr`       | 全局符号增量式重命名 (实时预览联动)         | inc-rename.nvim / 重构管道 | 联动 Native LSP 修改项目文件          |
| `<A-CR>`           | 意图操作与快速修复 (自动导入/修复报错)      | Native LSP / 重构意图分发  | 对应 IDEA Alt+Enter                   |
| `<A-7>`            | 切换 代码抽象大纲面板 (类/结构体/函数树)    | aerial.nvim / AST 结构树   | 对应 IDEA Alt+7 侧边栏                |
| `<Leader>m`        | 代码块 单行/多行抽象语法树结构化无损变换    | treesj / 语法树变换        | 保持语法绝对安全地自动拆折行          |
| `s`                | 全屏幕 二维字符拓扑高维视觉制导瞬时跳跃     | flash.nvim / 运动矩阵      | 盲打两码闪现到目标字符                |
| `S`                | 基于 AST 语义块的 智能视觉区块选择          | flash.nvim / 选择矩阵      | 对应 IDEA Ctrl+W 连续选择             |
| `<Leader>fr`       | 打开 项目级可视化结构化替换矩阵控制台       | grug-far.nvim / 全局重构   | 对应 IDEA Ctrl+Shift+R                |
| `<Leader>lf`       | 全自动代码排版与物理折行                    | AstroLSP / 格式化中心      | 自动分流：前端 Prettier，后端 Rustfmt |
| `<C-o>`            | 切换到 右侧下一个标签页 (Buffer)            | astrocore / 标签导航       | 顶部标签页高频顺滑穿梭                |
| `<C-i>`            | 切换到 左侧上一个标签页 (Buffer)            | astrocore / 标签导航       | 顶部标签页高频顺滑穿梭                |
| `<C-s>`            | 强制保存当前文件                            | astrocore / 文件流控制     | 联动触发保存时自动格式化流            |
| `<Leader>c`        | 物理卸载关闭当前文件缓冲区                  | astrocore / 文件流控制     | 干净关闭，不破坏窗口布局              |

## 🛠️ 职责分明的核心插件清单

1. **系统底层与语言生态包 (Base & Packs)**

   AstroNvim/AstroNvim: 系统底座，提供轻量且极其高效的框架级生命周期钩子。

   astrocommunity.pack.rust: 官方社区 Rust 满血语言包，内置 rustaceanvim 与 crates.nvim，完美支撑多模块架构下的自动诊断与 Cargo 拓扑管理。

   astrocommunity.pack.vue & typescript: 针对现代大前端的语言增强组件，自动处理 Vue 文件的宏推导。

2. **全栈研发重器 (Full-Stack Engineering Tools)**

   kristijanhusak/vim-dadbod-ui: 数据库可视化交互面板，负责渲染数据库的树状表结构、视图。

   tpope/vim-dadbod: 数据库底层连接引擎，通过标准的 psql 管道与本地或 TrueNAS 上的 PostgreSQL 建立物理通信。

   kristijanhusak/vim-dadbod-completion: 数据库智能补全插件，动态读取物理表结构，自动在 .sql 草稿本中提示表字段。

   windwp/nvim-ts-autotag: 标签同步重命名模块，基于新版双层配置架构，改写 HTML/Vue 前端标签时自动对齐闭合标签。

   milanglacier/minuet-ai.nvim: AI 智能辅助编程引擎，与本地本地运行的 Ollama qwen2.5-coder 建立 FIM 补全流，接管打字阶段的大上下文推导。

3. **IDEA 工业级效率增强器 (IDE-Grade Enhancements)**

   nvim-neotest/neotest: 单元测试调度器，深度绑定 rustaceanvim 测试适配器，实时抓取测试树。

   folke/snacks.nvim (Picker/Scroll): 全能的增量索引矩阵与平滑动画渲染内核，提供双击空格全局搜索及带物理阻尼感的流畅滚动。

   lewis6991/gitsigns.nvim: 动态计算 Git 差分流，在行尾渲染实时 Inline Blame 提交历史元数据。

   stevearc/aerial.nvim: 基于 Tree-sitter 的 AST 大纲视图，以秒级拓扑解析代码的方法、结构体、类关系。

   Wansmer/treesj: 基于抽象语法树节点的重构组件，一键无损拆分/合并代码块（数组、匹配分支、对象）。

   smjonas/inc-rename.nvim: 强化的 LSP 重命名组件，提供在输入新变量名时全缓冲区同名引用的毫秒级变色联动。

   shellRaining/hlchunk.nvim: 智能识别当前的 Treesitter 闭包作用域，绘制跨越物理空行的垂直引导线。

   nvim-treesitter/nvim-treesitter-context: 顶层上下文钉扎器，当代码块超出屏幕时，在最上方临时锁定该函数头或类名。

   folke/flash.nvim: 二维字符拓扑精准跳跃引擎，通过标记覆盖消除肉眼寻找光标的停顿。

   Magicisen/grug-far.nvim: 基于高性能 ripgrep 构建的项目级全局重构/物理替换虚拟控制台。

4. **极致视觉美化 (Aesthetics & UI Overrides)**

   catppuccin/nvim: 系统色彩规范主轴，配置为 floats 强制深色、主背景全透明，完美融入桌面壁纸。

   xiyaowong/transparent.nvim: 透明底座引擎，强行擦除悬浮提示框、自动补全菜单、文件树底色的黑块，实现极致通透。

   folke/noice.nvim: 内核级 UI 重载器，将原生底部的搜索和命令流重定向为居中的毛玻璃浮动面板。

   saghen/blink.cmp: 新一代高性能异步补全引擎，配置了专属高辨识度几何图标，多线程渲染绝不卡顿。

# 插入模式下的心流保持按键 (Insert Mode)

| 快捷键             | 功能说明                                    | 触发源插件 / 功能职责      | 联动插件或特性                        |
| ------------------ | ------------------------------------------- | -------------------------- | ------------------------------------- |
| `<Leader><Leader>` | Search Everywhere 全局模糊检索一切          | snacks.picker / 搜索中心   | 完美复刻 IDEA 双击 Shift              |
| `<Leader>ff`       | 查找文件 (根据文件名物理检索)               | snacks.picker / 文件定位   | 对应 IDEA Ctrl+Shift+N                |
| `<Leader>fg`       | 全局文本流搜索 (根据关键字实时 Grep)        | snacks.picker / 文本检索   | 对应 IDEA Ctrl+Shift+F                |
| `<Leader>fr`       | 最近打开文件历史 (文件缓冲区历史追踪)       | snacks.picker / 历史溯源   | 对应 IDEA Ctrl+E                      |
| `gd`               | 跳转至符号定义绝对坐标                      | Native LSP / 语义解析      | 联动 snacks.picker 悬浮预览           |
| `gr`               | 溯源所有引用拓扑节点 (查找所有被调用的地方) | Native LSP / 语义解析      | 对应 IDEA Alt+F7                      |
| `gD`               | 跳转至符号的声明处 (Declaration)            | Native LSP / 语义解析      | 标准 LSP 规范                         |
| `<Leader>lr`       | 全局符号增量式重命名 (实时预览联动)         | inc-rename.nvim / 重构管道 | 联动 Native LSP 修改项目文件          |
| `<A-CR>`           | 意图操作与快速修复 (自动导入/修复报错)      | Native LSP / 重构意图分发  | 对应 IDEA Alt+Enter                   |
| `<A-7>`            | 切换 代码抽象大纲面板 (类/结构体/函数树)    | aerial.nvim / AST 结构树   | 对应 IDEA Alt+7 侧边栏                |
| `<Leader>m`        | 代码块 单行/多行抽象语法树结构化无损变换    | treesj / 语法树变换        | 保持语法绝对安全地自动拆折行          |
| `s`                | 全屏幕 二维字符拓扑高维视觉制导瞬时跳跃     | flash.nvim / 运动矩阵      | 盲打两码闪现到目标字符                |
| `S`                | 基于 AST 语义块的 智能视觉区块选择          | flash.nvim / 选择矩阵      | 对应 IDEA Ctrl+W 连续选择             |
| `<Leader>fr`       | 打开 项目级可视化结构化替换矩阵控制台       | grug-far.nvim / 全局重构   | 对应 IDEA Ctrl+Shift+R                |
| `<Leader>lf`       | 全自动代码排版与物理折行                    | AstroLSP / 格式化中心      | 自动分流：前端 Prettier，后端 Rustfmt |
| `<C-o>`            | 切换到 右侧下一个标签页 (Buffer)            | astrocore / 标签导航       | 顶部标签页高频顺滑穿梭                |
| `<C-i>`            | 切换到 左侧上一个标签页 (Buffer)            | astrocore / 标签导航       | 顶部标签页高频顺滑穿梭                |
| `<C-s>`            | 强制保存当前文件                            | astrocore / 文件流控制     | 联动触发保存时自动格式化流            |
| `<Leader>c`        | 物理卸载关闭当前文件缓冲区                  | astrocore / 文件流控制     | 干净关闭，不破坏窗口布局              |
| `<A-h>`            | 光标向左微调一格                            | astrocore / 键位重写       | 告别 Esc，打字时手指永不离主键盘区    |
| `<A-l>`            | 光标向右微调一格 (用于直接跨出括号)         | astrocore / 键位重写       | 告别 Esc，打字时手指永不离主键盘区    |
| `<A-j>`            | 光标向下微调一行                            | astrocore / 键位重写       | 告别 Esc，打字时手指永不离主键盘区    |
| `<A-k>`            | 光标向上微调一行                            | astrocore / 键位重写       | 告别 Esc，打字时手指永不离主键盘区    |
| `<A-CR>`           | 在输入打字状态下直接呼出快速修复面板        | Native LSP / 意图分发      | 极其硬核，不中断打字心流直接修报错    |
| `<A-i>`            | 手动强行召唤本地 AI 给出代码流补全          | minuet-ai.nvim / AI 引擎   | 抑制自动闪烁，只在需要时由极客触发    |
| `<A-a>`            | 采纳并写入 AI 给出的当前行级代码建议        | minuet-ai.nvim / 虚拟文本  | 快速采纳 AI 代码补全                  |
| `<A-e>`            | 拒绝并隐去当前屏幕上的 AI 代码提示          | minuet-ai.nvim / 虚拟文本  | 快速中断 AI 代码补全                  |
| `<C-y>`            | 轮询切换到 下一个 AI 备选代码片段           | minuet-ai.nvim / 补全列表  | 大模型大上下文片段筛选                |
| `<C-o>`            | 轮询切换到 上一个 AI 备选代码片段           | minuet-ai.nvim / 补全列表  | 大模型大上下文片段筛选                |
| `<C-s>`            | 瞬间保存代码并回退到普通模式                | astrocore / 文件流控制     | 极速下盘物理落盘保存                  |

**🗃️ 关系型数据库操纵矩阵 (vim-dadbod-ui 面板内或 SQL 缓冲区)**

    :DBUIToggle (Terminal Command): 在普通模式下直接呼出或隐藏左侧的数据库管理面板。

    A (Shift + a, 面板内): 物理激活新连接输入框，支持输入标准的 postgresql://user:pass@host:5432/db。

    <C-o> (面板内选中数据库): 瞬间创建该数据库专属的名为 .sql 的独立查询草稿本缓冲区。

    Enter (面板内): 折叠或展开当前高亮的表结构、视图字段。

    Enter 或 <C-CR> (.sql 草稿本内): 选中某段 SQL 语句直接运行，在正下方以完美对齐的表格高亮渲染出数据集结果。

**📁 模块化文件拓扑树 (neo-tree 侧边栏内)**

    H (Shift + h, 文件树内): 智能物理透视开关。一键在“清爽模式”与“全量模式”之间切换，让隐藏的系统点文件（如 .env, .gitignore, .prettierrc）瞬间在左侧变灰显形。

**🧪 单元测试全生命周期控制台 (neotest 面板与代码交互)**

    <Leader>tr: 测试：运行当前光标函数。精准定位当前 Rust 函数或前端用例并在后台并发执行。

    <Leader>tf: 测试：运行当前文件所有用例。批量跑完当前缓冲区的全量测试流。

    <Leader>ts: 测试：切换可视化状态树面板。在右侧以树状图实时渲染测试通过（绿色）或断言失败（红色）的拓扑图。

    <Leader>to: 测试：打开控制台标准输出日志。直接调出单元测试输出的控制台面板，查看 Rust 报错的 panic! 详细行号及堆栈。
