# neovim config

[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [한국어](README.ko.md)

一份个人的、现代化的 Neovim 配置，使用 Lua 编写，由
[lazy.nvim](https://github.com/folke/lazy.nvim) 管理。原生 LSP、Treesitter、
Telescope 加 Catppuccin 主题，开箱即用，针对 Web 与 Python 开发做了调优。

![screenshot](./assets/leader.jpg)

## 特性

- ⚡ **懒加载** — 由 lazy.nvim 管理插件，并提交 `lazy-lock.json` 以保证安装可复现
- 🧠 **原生 LSP** — `nvim-lspconfig` + `mason.nvim`，自动安装 server 与工具
- ✨ **补全** — [blink.cmp](https://github.com/Saghen/blink.cmp)，快速的现代补全引擎
- 🌳 **Treesitter** — 语法高亮与增量选择，外加基于 Treesitter 的文本对象
- 🔭 **Telescope** — 文件、实时 grep、LSP 符号、todo 的模糊查找
- 🎨 **Catppuccin** 主题、`lualine` 状态栏、`alpha` 启动页、`which-key` 提示与缩进线
- 🧹 **保存时格式化与 lint** — `conform.nvim`（prettier / stylua / isort /
  black）与 `nvim-lint`（eslint_d / pylint）
- 💾 **自动会话** — 按项目目录恢复工作区
- 🔧 通过 `gitsigns` 与 `lazygit` 集成 Git

## 环境要求

- **Neovim** 0.10 或更高版本
- **git**
- 一款 **Nerd Font**（用于图标；配置假定你的终端已设置）
- **真彩色终端**（iTerm2、WezTerm、Kitty 等）—— `termguicolors` 所必需
- **ripgrep**（`rg`）—— Telescope 实时 grep 所需
- **Node.js** —— 若干 LSP server 与格式化工具（如 prettier）依赖它

## 安装

```bash
git clone git@github.com:dofy/nvim.git ~/.config/nvim
```

然后启动 Neovim：

```bash
nvim
```

首次启动时，lazy.nvim 会自动完成自举并安装全部插件。LSP server 与工具由 Mason 在
后台安装。

- 执行 `:Lazy` 安装 / 更新 / 清理插件
- 执行 `:Mason` 管理 LSP server、格式化器与 linter
- 按 `<Space>`（leader 键）并稍候，即可看到可用的快捷键
- 按 `g?` 查看快捷键界面

## 目录结构

```
init.lua
├── lua/custom/core/
│   ├── options.lua     # vim.opt 设置
│   └── keymaps.lua     # 基础快捷键（leader = <Space>）
├── lua/custom/lazy.lua # lazy.nvim 自举 + 插件导入
└── lua/custom/plugins/
    ├── init.lua        # 基础依赖（plenary、vim-tmux-navigator）
    ├── lsp/
    │   ├── mason.lua       # Mason + mason-lspconfig + 工具安装器
    │   └── lspconfig.lua   # nvim-lspconfig + LspAttach 快捷键
    └── *.lua           # 每个插件一个文件
```

新增插件：在 `lua/custom/plugins/` 下创建 `<name>.lua`，返回一个 lazy.nvim 的 spec
表即可 —— 会被自动导入。

## 插件

| 类别 | 插件 |
| --- | --- |
| 补全 | blink.cmp |
| LSP | nvim-lspconfig、mason.nvim、mason-lspconfig、mason-tool-installer |
| 语法 | nvim-treesitter、nvim-treesitter-textobjects |
| 文件与搜索 | nvim-tree、telescope.nvim |
| 格式化与 lint | conform.nvim、nvim-lint |
| 界面 | catppuccin、lualine、alpha、dressing、indent-blankline、which-key |
| 编辑 | autopairs、substitute.nvim、todo-comments、trouble.nvim |
| Git | gitsigns、lazygit |
| 会话与其他 | auto-session、wakatime |

## 快捷键

leader 键为 `<Space>`。下面是速查表；按 `<leader>` 或 `g` 稍候，`which-key` 会显示
完整列表。

### 窗口与标签页

| 快捷键 | 作用 |
| --- | --- |
| `<leader>sv` / `<leader>sh` | 垂直 / 水平分屏 |
| `<leader>se` / `<leader>sx` | 等分窗口 / 关闭分屏 |
| `<leader>to` / `<leader>tx` | 打开 / 关闭标签页 |
| `<leader>tn` / `<leader>tp` | 下一个 / 上一个标签页 |
| `<leader>tf` | 在新标签页打开当前 buffer |
| `<leader>nh` | 清除搜索高亮 |
| `jk`（插入模式） | 退出插入模式 |

### 查找（Telescope）与文件树

| 快捷键 | 作用 |
| --- | --- |
| `<leader>ff` | 在当前目录查找文件 |
| `<leader>fr` | 最近文件 |
| `<leader>fs` | 当前目录实时 grep |
| `<leader>fc` | grep 光标下的字符串 |
| `<leader>ft` | 查找 todo |
| `<leader>ee` | 切换文件树 |
| `<leader>ef` | 对当前文件切换文件树 |
| `<leader>ec` / `<leader>er` | 折叠 / 刷新文件树 |

### LSP

| 快捷键 | 作用 |
| --- | --- |
| `gd` / `gR` | 定义 / 引用 |
| `gD` / `gi` / `gt` | 声明 / 实现 / 类型定义 |
| `K` | 悬浮文档 |
| `<leader>ca` | 代码操作 |
| `<leader>rn` | 重命名符号 |
| `<leader>d` / `<leader>D` | 行 / 文件诊断 |
| `[d` / `]d` | 上一个 / 下一个诊断 |
| `<leader>rs` | 重启 LSP |

### 编辑

| 快捷键 | 作用 |
| --- | --- |
| `s` + 移动 / `ss` / `S` | 按移动 / 整行 / 到行尾替换 |
| `s`（visual） | 替换选区 |
| `<leader>fo` | 格式化文件或选区 |
| `<leader>ll` | 触发 lint |
| `<leader>wr` / `<leader>ws` | 恢复 / 保存会话 |

## LSP 与格式化

**LSP server**（经 `mason-lspconfig` 自动安装）：`ts_ls`、`denols`、`html`、
`cssls`、`tailwindcss`、`svelte`、`lua_ls`、`graphql`、`emmet_ls`、`prismals`、
`pyright`。

**工具**（经 `mason-tool-installer` 自动安装）：`prettier`、`stylua`、`isort`、
`black`、`pylint`、`eslint_d`。

**格式化** —— `conform.nvim`，保存时自动运行（手动：`<leader>fo`）：

- JS / TS / CSS / HTML / JSON / YAML / Markdown / GraphQL → prettier
- Lua → stylua（2 空格缩进）
- Python → isort + black

**Lint** —— `nvim-lint`，在进入 / 保存 / 离开插入模式时触发（手动：`<leader>ll`）：

- JS / TS / Svelte → eslint_d
- Python → pylint

## 许可证

[MIT](LICENSE)
