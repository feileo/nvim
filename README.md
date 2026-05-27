# nvim-starter

基于 [NvChad](https://nvchad.com/) 的个人 Neovim 配置，通过 [nvim-core](https://github.com/feileo/nvim-core) 作为插件框架，在其上做定制覆盖。

## 架构

```
nvim-starter/
├── init.lua           ← 入口：加载 nvim-core + 本地覆盖
└── lua/
    ├── plugins/       ← 插件覆盖层（覆盖 nvim-core 的默认 spec）
    ├── configs/       ← 各插件的详细配置
    ├── chadrc.lua     ← NvChad 主题 & UI 配置
    ├── options.lua    ← vim.opt 设置
    ├── mappings.lua   ← 快捷键
    ├── autocmds.lua   ← 自动命令
    ├── cmds.lua       ← 用户命令
    ├── highlights.lua ← 高亮覆盖
    └── util.lua       ← 工具函数
```

**覆盖机制**：lazy.nvim 按插件名合并 spec，`plugins/init.lua` 中同名插件的 `opts`/`keys`/`config` 会覆盖 nvim-core 的默认值。详细配置放在 `configs/*.lua`，通过 `opts = function() return require "configs.xxx" end` 引用。

## 依赖

- Neovim >= 0.11
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep)（Telescope grep）
- [Nerd Font](https://www.nerdfonts.com/)（图标显示，推荐 Maple Mono NF CN）
- Node.js（部分 LSP 依赖）

## 安装

```sh
# 1. 备份旧配置（如有）
mv ~/.config/nvim ~/.config/nvim.bak

# 2. 安装
ln -sv $MDE/nvim-starter $HOME/.config/nvim

# 3. 启动 nvim，等待 lazy.nvim 自动安装插件
nvim

# 4. 安装 LSP / formatter / linter
:MasonInstallAll

# 5. 安装 Go 工具链（仅 Go 开发需要）
:GoInstallDeps
```

## 插件列表

| 插件 | 用途 |
|------|------|
| [nvim-core](https://github.com/feileo/nvim-core) | NvChad 核心框架（base46 主题、UI、LSP 默认配置） |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮（Go 除外，见下方说明） |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 客户端配置 |
| [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) | LSP UI 增强（peek、finder、outline、rename） |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP / formatter / linter 安装管理 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 格式化（保存时自动触发） |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 补全引擎 |
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI 代码补全 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊搜索 |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件树 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 行内标记 |
| [gopher.nvim](https://github.com/olexsmir/gopher.nvim) | Go 开发工具（tag、test、impl） |
| [noice.nvim](https://github.com/folke/noice.nvim) | 命令行 / 通知 UI 美化 |
| [pantran.nvim](https://github.com/potamides/pantran.nvim) | 翻译（Google，目标语言 zh-CN） |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | 括号/引号包围操作 |
| [dashboard-nvim](https://github.com/glepnir/dashboard-nvim) | 启动页 |
| [interestingwords.nvim](https://github.com/leisiji/interestingwords.nvim) | 多词高亮 |
| [better-escape.nvim](https://github.com/max397574/better-escape.nvim) | 快速退出 insert 模式 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进参考线 |
| [flash.nvim](https://github.com/folke/flash.nvim) | 快速跳转（字符标签 + treesitter 节点） |

## LSP 支持

通过 Mason 管理，已配置的 LSP：

| 语言 | LSP |
|------|-----|
| Go | `gopls` |
| Python | `pyright` |
| Lua | `lua_ls`（nvim-core 内置） |
| HTML | `html` |
| CSS | `cssls` |
| Bash | `bashls` |
| C/C++ | `clangd` |

**注意**：`lua_ls` 由 nvim-core 通过 `vim.lsp.enable "lua_ls"`（0.11+ API）启用，不要在 `configs/lspconfig.lua` 里重复 setup，否则会双重初始化。

## 格式化

由 conform.nvim 管理，保存时自动触发：

| 语言 | Formatter |
|------|-----------|
| Go | `goimports` → `gofmt` |
| Lua | `stylua` |
| Python | `ruff`（优先）/ `isort` + `black` + `autopep8` |
| Rust | `rustfmt` |
| CSS / HTML | `prettier` |

临时禁用：
```
:FormatDisable    " 全局禁用
:FormatDisable!   " 仅当前 buffer
:FormatEnable     " 重新启用
```

## Go 语法高亮

Go 文件使用 `syntax/go.vim`（Charles Pascoe 的自定义语法文件），**不使用 treesitter**（treesitter 对 Go 已禁用）。高亮行为通过 `options.lua` 中的 `vim.g.go_highlight_*` 变量控制：

```lua
g.go_highlight_fields = 1
g.go_highlight_struct_type_fields = 1
g.go_highlight_comma = 1
g.go_highlight_semicolon = 1
-- 以下默认关闭（避免过度高亮）
g.go_highlight_variable_assignments = 0
g.go_highlight_variable_declarations = 0
```

## 快捷键

`<leader>` 键为 `Space`。

### 文件 & 搜索

| 快捷键 | 功能 |
|--------|------|
| `'` | 切换文件树 |
| `"` | 聚焦文件树 |
| `<leader>ff` | 查找文件 |
| `<leader>fo` | 最近文件 |
| `<leader>fa` | 查找所有文件（含隐藏） |
| `<leader>fb` | 查找 buffer |
| `<leader>fw` | find word |
| `<leader>ss` | 全局 grep |
| `<leader>sw` | 全局 grep 当前光标词 |
| `<leader>sd` | LSP 文档符号 |

### Buffer & 窗口

| 快捷键 | 功能 |
|--------|------|
| `<Tab>` | 下一个 buffer |
| `<S-Tab>` | 上一个 buffer |
| `<leader><Tab>` | buffer 列表 |
| `<leader>w` | 保存当前 buffer |
| `<leader>W` | 保存所有 buffer |
| `<leader>x` | 关闭当前 buffer |
| `<leader>X` | 关闭其他 buffer |
| `<C-c>` | 关闭当前窗口（NvimTree 感知） |
| `<C-q>` | 退出 |
| `<A-q>` | 安全退出（有未保存时弹确认框） |

### LSP（nvim-core 默认 + lspsaga）

| 快捷键 | 功能 |
|--------|------|
| `K` | 悬浮文档 |
| `gd` | 跳转定义 |
| `gD` | 跳转类型定义 |
| `gp` | Peek 定义（浮窗预览） |
| `gP` | Peek 类型定义 |
| `gf` | Finder（引用 + 定义） |
| `gi` | 查找实现 |
| `gr` | 查找引用 |
| `gn` | 重命名（NvChad renamer） |
| `gN` | 重命名（跨项目） |
| `gca` | Code action |
| `gco` | 查看 outgoing calls |
| `gci` | 查看 incoming calls |
| `<leader>d` | 跳转定义 |
| `<leader>D` | 跳转类型定义 |
| `<leader>p` | Peek 定义 |
| `<leader>e` | 当前文件诊断 |
| `<leader>E` | 工作区诊断 |
| `<leader>0` | 代码大纲（float） |

### 终端

| 快捷键 | 功能 |
|--------|------|
| `<A-m>` | 浮动终端 toggle |
| `<A-s>` | 水平终端 toggle |
| `<A-v>` | 垂直终端 toggle |
| `<C-c>`（终端内） | 关闭终端 |

### 编辑

| 快捷键 | 功能 |
|--------|------|
| `<C-b>` | 行首 |
| `<C-n>` | 行尾 |
| `<C-]>` | 右移 4 列（水平滚动） |
| `<C-[>` | 左移 4 列 |
| `<C-k>` / `<C-j>`（visual） | 上 / 下移选中行 |
| `<C-h>` / `<C-l>`（visual） | 减少 / 增加缩进 |
| `;` | 进入命令模式（替代 `:`） |
| `@` | 开始 / 停止宏录制（原 `q`） |
| `Q` | 执行宏（原 `@`） |
| `p`（visual） | 粘贴且不覆盖寄存器 |

### 翻译

| 快捷键 | 功能 |
|--------|------|
| `<leader>t` + motion | 翻译 motion 范围（→ zh-CN） |
| `<leader>tt` | 翻译当前行 |
| `<leader>t`（visual） | 翻译选中内容 |

### 跳转（flash.nvim）

| 快捷键 | 功能 |
|--------|------|
| `s` | 输入字符，标签跳转到任意位置 |
| `S` | treesitter 节点跳转 |
| `<C-s>`（搜索中） | 在 `/` 搜索时激活 flash 标签 |

### 其他

| 快捷键 | 功能 |
|--------|------|
| `<A-i>` | 高亮 / 取消高亮当前词 |
| `<A-I>` | 清除所有词高亮 |
| `<leader>th` | 切换 NvChad 主题 |
| `<leader>gc` | Git commits |
| `<leader>gs` | Git status |

## 用户命令

| 命令 | 功能 |
|------|------|
| `:Format` | 手动格式化（支持 range） |
| `:FormatDisable[!]` | 禁用自动格式化（`!` 仅当前 buffer） |
| `:FormatEnable` | 重新启用自动格式化 |
| `:ExitSafe` | 安全退出（有未保存时弹确认） |
| `:MouseToggle` | 切换鼠标支持 |
| `:CloseWindow` | 关闭窗口（NvimTree 感知） |
| `:PeekDefinitionToggle` | toggle lspsaga peek 定义浮窗 |

## Neovide 支持

在 Neovide GUI 下自动应用：
- 字体：Maple Mono NF CN 13pt
- 行间距、平滑滚动、光标动画、95% 透明度

## 主题

默认主题 `onedark`，通过 `<leader>th` 可实时切换所有 NvChad 内置主题。主题配置在 `chadrc.lua`。
