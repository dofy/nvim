# neovim config

[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [한국어](README.ko.md)

A personal, modern Neovim configuration written in Lua and managed with
[lazy.nvim](https://github.com/folke/lazy.nvim). Native LSP, Treesitter,
Telescope, and a Catppuccin theme — batteries included, tuned for web and Python
development.

![screenshot](./assets/leader.jpg)

## Features

- ⚡ **Lazy loading** — plugins managed by lazy.nvim with a committed
  `lazy-lock.json` for reproducible installs
- 🧠 **Native LSP** — `nvim-lspconfig` + `mason.nvim`, servers and tools
  installed automatically
- ✨ **Completion** — [blink.cmp](https://github.com/Saghen/blink.cmp), a fast
  modern completion engine
- 🌳 **Treesitter** — syntax highlighting and incremental selection, plus
  Treesitter-based text objects
- 🔭 **Telescope** — fuzzy finding for files, live grep, LSP symbols, and todos
- 🎨 **Catppuccin** theme, `lualine` statusline, `alpha` dashboard, `which-key`
  hints, and indent guides
- 🧹 **Format & lint on save** — `conform.nvim` (prettier / stylua / isort /
  black) and `nvim-lint` (eslint_d / pylint)
- 💾 **Auto session** — restore your workspace per project directory
- 🔧 Git integration via `gitsigns` and `lazygit`

## Requirements

- **Neovim** 0.10 or newer
- **git**
- A **Nerd Font** (for icons; the config assumes one is set in your terminal)
- A **true-color terminal** (iTerm2, WezTerm, Kitty, etc.) — required for
  `termguicolors`
- **ripgrep** (`rg`) — for Telescope live grep
- **Node.js** — required by several LSP servers and formatters (prettier, etc.)

## Installation

```bash
git clone git@github.com:dofy/nvim.git ~/.config/nvim
```

Then launch Neovim:

```bash
nvim
```

On first start, lazy.nvim bootstraps itself and installs all plugins
automatically. LSP servers and tools are installed by Mason in the background.

- Run `:Lazy` to install / update / clean plugins
- Run `:Mason` to manage LSP servers, formatters, and linters
- Press `<Space>` (the leader key) and wait to see available keybindings
- Press `g?` to view the keybindings screen

## Structure

```
init.lua
├── lua/custom/core/
│   ├── options.lua     # vim.opt settings
│   └── keymaps.lua     # base keymaps (leader = <Space>)
├── lua/custom/lazy.lua # lazy.nvim bootstrap + plugin imports
└── lua/custom/plugins/
    ├── init.lua        # base dependencies (plenary, vim-tmux-navigator)
    ├── lsp/
    │   ├── mason.lua       # Mason + mason-lspconfig + tool installer
    │   └── lspconfig.lua   # nvim-lspconfig + LspAttach keymaps
    └── *.lua           # one file per plugin
```

To add a plugin, create `lua/custom/plugins/<name>.lua` returning a lazy.nvim
spec table — it is auto-imported.

## Plugins

| Category | Plugins |
| --- | --- |
| Completion | blink.cmp |
| LSP | nvim-lspconfig, mason.nvim, mason-lspconfig, mason-tool-installer |
| Syntax | nvim-treesitter, nvim-treesitter-textobjects |
| Files & search | nvim-tree, telescope.nvim |
| Format & lint | conform.nvim, nvim-lint |
| UI | catppuccin, lualine, alpha, dressing, indent-blankline, which-key |
| Editing | autopairs, substitute.nvim, todo-comments, trouble.nvim |
| Git | gitsigns, lazygit |
| Session & misc | auto-session, wakatime |

## Keymaps

Leader key is `<Space>`. This is a quick reference; press `<leader>` or `g` and
wait for `which-key` to show the full list.

### Windows & tabs

| Key | Action |
| --- | --- |
| `<leader>sv` / `<leader>sh` | Split vertically / horizontally |
| `<leader>se` / `<leader>sx` | Equalize splits / close split |
| `<leader>to` / `<leader>tx` | Open / close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>tf` | Open current buffer in a new tab |
| `<leader>nh` | Clear search highlights |
| `jk` (insert) | Exit insert mode |

### Find (Telescope) & explorer

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files in cwd |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep in cwd |
| `<leader>fc` | Grep string under cursor |
| `<leader>ft` | Find todos |
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Toggle explorer on current file |
| `<leader>ec` / `<leader>er` | Collapse / refresh explorer |

### LSP

| Key | Action |
| --- | --- |
| `gd` / `gR` | Definitions / references |
| `gD` / `gi` / `gt` | Declaration / implementations / type definitions |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` / `<leader>D` | Line / file diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

### Editing

| Key | Action |
| --- | --- |
| `s` + motion / `ss` / `S` | Substitute with motion / line / to end of line |
| `s` (visual) | Substitute selection |
| `<leader>fo` | Format file or range |
| `<leader>ll` | Trigger lint |
| `<leader>wr` / `<leader>ws` | Restore / save session |

## LSP & Formatting

**LSP servers** (auto-installed via `mason-lspconfig`): `ts_ls`, `denols`,
`html`, `cssls`, `tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`,
`prismals`, `pyright`.

**Tools** (auto-installed via `mason-tool-installer`): `prettier`, `stylua`,
`isort`, `black`, `pylint`, `eslint_d`.

**Formatting** — `conform.nvim`, runs on save (manual: `<leader>fo`):

- JS / TS / CSS / HTML / JSON / YAML / Markdown / GraphQL → prettier
- Lua → stylua (2-space indent)
- Python → isort + black

**Linting** — `nvim-lint`, triggers on enter / save / leaving insert (manual:
`<leader>ll`):

- JS / TS / Svelte → eslint_d
- Python → pylint

## License

[MIT](LICENSE)
