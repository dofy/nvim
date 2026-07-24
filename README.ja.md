# neovim config

[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [한국어](README.ko.md)

Lua で書かれた、個人用のモダンな Neovim 設定。プラグイン管理には
[lazy.nvim](https://github.com/folke/lazy.nvim) を使用しています。ネイティブ LSP、
Treesitter、Telescope、Catppuccin テーマを同梱し、Web および Python 開発向けに
チューニングしてあります。

![screenshot](./assets/leader.jpg)

## 特徴

- ⚡ **遅延読み込み** — lazy.nvim によるプラグイン管理。再現性のある構築のため
  `lazy-lock.json` をコミット
- 🧠 **ネイティブ LSP** — `nvim-lspconfig` + `mason.nvim`。サーバーとツールを自動
  インストール
- ✨ **補完** — [blink.cmp](https://github.com/Saghen/blink.cmp)、高速でモダンな
  補完エンジン
- 🌳 **Treesitter** — シンタックスハイライトとインクリメンタル選択、さらに
  Treesitter ベースのテキストオブジェクト
- 🔭 **Telescope** — ファイル、ライブ grep、LSP シンボル、todo のあいまい検索
- 🎨 **Catppuccin** テーマ、`lualine` ステータスライン、`alpha` ダッシュボード、
  `which-key` ヒント、インデントガイド
- 🧹 **保存時のフォーマットと lint** — `conform.nvim`（prettier / stylua / isort /
  black）と `nvim-lint`（eslint_d / pylint）
- 💾 **自動セッション** — プロジェクトディレクトリごとにワークスペースを復元
- 🔧 `gitsigns` と `lazygit` による Git 連携

## 必要環境

- **Neovim** 0.10 以上
- **git**
- **Nerd Font**（アイコン用。ターミナルで設定済みであることを前提とします）
- **トゥルーカラー対応ターミナル**（iTerm2、WezTerm、Kitty など）—— `termguicolors`
  に必要
- **ripgrep**（`rg`）—— Telescope のライブ grep に必要
- **Node.js** —— いくつかの LSP サーバーとフォーマッター（prettier など）が依存

## インストール

```bash
git clone git@github.com:dofy/nvim.git ~/.config/nvim
```

その後 Neovim を起動します：

```bash
nvim
```

初回起動時に lazy.nvim が自身をブートストラップし、すべてのプラグインを自動的に
インストールします。LSP サーバーとツールは Mason がバックグラウンドで
インストールします。

- `:Lazy` でプラグインのインストール / 更新 / クリーンアップ
- `:Mason` で LSP サーバー、フォーマッター、linter を管理
- `<Space>`（leader キー）を押してしばらく待つと、利用可能なキーバインドが表示されます
- `g?` でキーバインド画面を表示

## ディレクトリ構成

```
init.lua
├── lua/custom/core/
│   ├── options.lua     # vim.opt の設定
│   └── keymaps.lua     # 基本キーマップ（leader = <Space>）
├── lua/custom/lazy.lua # lazy.nvim のブートストラップ + プラグイン読み込み
└── lua/custom/plugins/
    ├── init.lua        # 基本依存（plenary、vim-tmux-navigator）
    ├── lsp/
    │   ├── mason.lua       # Mason + mason-lspconfig + ツールインストーラー
    │   └── lspconfig.lua   # nvim-lspconfig + LspAttach キーマップ
    └── *.lua           # プラグインごとに 1 ファイル
```

プラグインを追加するには、`lua/custom/plugins/` に `<name>.lua` を作成し、
lazy.nvim の spec テーブルを返します —— 自動的に読み込まれます。

## プラグイン

| カテゴリ | プラグイン |
| --- | --- |
| 補完 | blink.cmp |
| LSP | nvim-lspconfig、mason.nvim、mason-lspconfig、mason-tool-installer |
| シンタックス | nvim-treesitter、nvim-treesitter-textobjects |
| ファイルと検索 | nvim-tree、telescope.nvim |
| フォーマットと lint | conform.nvim、nvim-lint |
| UI | catppuccin、lualine、alpha、dressing、indent-blankline、which-key |
| 編集 | autopairs、substitute.nvim、todo-comments、trouble.nvim |
| Git | gitsigns、lazygit |
| セッションとその他 | auto-session、wakatime |

## キーマップ

leader キーは `<Space>` です。以下はクイックリファレンスです。`<leader>` または
`g` を押してしばらく待つと、`which-key` が全リストを表示します。

### ウィンドウとタブ

| キー | 動作 |
| --- | --- |
| `<leader>sv` / `<leader>sh` | 垂直 / 水平分割 |
| `<leader>se` / `<leader>sx` | 分割を均等化 / 分割を閉じる |
| `<leader>to` / `<leader>tx` | タブを開く / 閉じる |
| `<leader>tn` / `<leader>tp` | 次の / 前のタブ |
| `<leader>tf` | 現在のバッファを新しいタブで開く |
| `<leader>nh` | 検索ハイライトを消去 |
| `jk`（挿入モード） | 挿入モードを終了 |

### 検索（Telescope）とエクスプローラー

| キー | 動作 |
| --- | --- |
| `<leader>ff` | カレントディレクトリでファイル検索 |
| `<leader>fr` | 最近使ったファイル |
| `<leader>fs` | カレントディレクトリでライブ grep |
| `<leader>fc` | カーソル下の文字列を grep |
| `<leader>ft` | todo を検索 |
| `<leader>ee` | ファイルエクスプローラーの切り替え |
| `<leader>ef` | 現在のファイルに対してエクスプローラーを切り替え |
| `<leader>ec` / `<leader>er` | エクスプローラーを折りたたむ / 更新 |

### LSP

| キー | 動作 |
| --- | --- |
| `gd` / `gR` | 定義 / 参照 |
| `gD` / `gi` / `gt` | 宣言 / 実装 / 型定義 |
| `K` | ホバードキュメント |
| `<leader>ca` | コードアクション |
| `<leader>rn` | シンボルのリネーム |
| `<leader>d` / `<leader>D` | 行 / ファイルの診断 |
| `[d` / `]d` | 前の / 次の診断 |
| `<leader>rs` | LSP を再起動 |

### 編集

| キー | 動作 |
| --- | --- |
| `s` + モーション / `ss` / `S` | モーション / 行 / 行末まで置換 |
| `s`（visual） | 選択範囲を置換 |
| `<leader>fo` | ファイルまたは範囲をフォーマット |
| `<leader>ll` | lint を実行 |
| `<leader>wr` / `<leader>ws` | セッションを復元 / 保存 |

## LSP とフォーマット

**LSP サーバー**（`mason-lspconfig` により自動インストール）：`ts_ls`、`denols`、
`html`、`cssls`、`tailwindcss`、`svelte`、`lua_ls`、`graphql`、`emmet_ls`、
`prismals`、`pyright`。

**ツール**（`mason-tool-installer` により自動インストール）：`prettier`、
`stylua`、`isort`、`black`、`pylint`、`eslint_d`。

**フォーマット** —— `conform.nvim`、保存時に実行（手動：`<leader>fo`）：

- JS / TS / CSS / HTML / JSON / YAML / Markdown / GraphQL → prettier
- Lua → stylua（2 スペースインデント）
- Python → isort + black

**Lint** —— `nvim-lint`、入力 / 保存 / 挿入モード終了時に実行（手動：`<leader>ll`）：

- JS / TS / Svelte → eslint_d
- Python → pylint

## ライセンス

[MIT](LICENSE)
