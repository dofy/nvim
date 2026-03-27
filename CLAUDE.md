# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Written in Lua.

## Architecture

Entry point: `init.lua` → loads `lua/custom/core/` then `lua/custom/lazy.lua`

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

## Plugin Management

- **`:Lazy`** — open lazy.nvim UI (install/update/clean plugins)
- **`:Mason`** — manage LSP servers and formatters/linters
- Lock file: `lazy-lock.json` — commit changes to this when updating plugins intentionally

## LSP Setup (mason.lua)

Servers auto-installed via `mason-lspconfig`: `ts_ls`, `denols`, `html`, `cssls`, `tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`, `prismals`, `pyright`

Tools auto-installed via `mason-tool-installer`: `prettier`, `stylua`, `isort`, `black`, `pylint`, `eslint_d`

## Formatting & Linting

- **Formatting**: `conform.nvim` — runs on save automatically; manual trigger: `<leader>fo`
  - JS/TS/CSS/HTML/JSON/YAML/Markdown/GraphQL → prettier
  - Lua → stylua (config: `lua/custom/.stylua.toml`, 2-space indent)
  - Python → isort + black
- **Linting**: `nvim-lint` — triggers on BufEnter/BufWritePost/InsertLeave; manual: `<leader>ll`
  - JS/TS/Svelte → eslint_d; Python → pylint

## Adding a New Plugin

Create `lua/custom/plugins/<name>.lua` returning a lazy.nvim plugin spec table. It is auto-imported via `{ import = "custom.plugins" }` in `lazy.lua`.

## Key Keymaps Reference

| Key | Action |
|-----|--------|
| `<leader>ff` | Telescope find files |
| `<leader>fs` | Telescope live grep |
| `<leader>ee` | Toggle nvim-tree |
| `<leader>fo` | Format file/range |
| `<leader>ll` | Trigger lint |
| `<leader>ca` | Code actions (LSP) |
| `<leader>rn` | Rename (LSP) |
| `gd` / `gR` | LSP definition / references |
| `K` | Hover docs (LSP) |
| `<leader>rs` | Restart LSP |
