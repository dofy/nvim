# neovim config

[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [한국어](README.ko.md)

Lua로 작성하고 [lazy.nvim](https://github.com/folke/lazy.nvim)으로 관리하는 개인용
모던 Neovim 설정입니다. 네이티브 LSP, Treesitter, Telescope, Catppuccin 테마를
기본 포함하며 웹 및 Python 개발에 맞춰 튜닝했습니다.

![screenshot](./assets/leader.jpg)

## 특징

- ⚡ **지연 로딩** — lazy.nvim으로 플러그인을 관리하며, 재현 가능한 설치를 위해
  `lazy-lock.json`을 커밋합니다
- 🧠 **네이티브 LSP** — `nvim-lspconfig` + `mason.nvim`, 서버와 도구를 자동 설치
- ✨ **자동완성** — [blink.cmp](https://github.com/Saghen/blink.cmp), 빠르고 모던한
  자동완성 엔진
- 🌳 **Treesitter** — 구문 강조와 점진적 선택, 그리고 Treesitter 기반 텍스트 오브젝트
- 🔭 **Telescope** — 파일, 실시간 grep, LSP 심볼, todo에 대한 퍼지 검색
- 🎨 **Catppuccin** 테마, `lualine` 상태 표시줄, `alpha` 대시보드, `which-key` 힌트,
  들여쓰기 가이드
- 🧹 **저장 시 포맷팅과 lint** — `conform.nvim`(prettier / stylua / isort / black)과
  `nvim-lint`(eslint_d / pylint)
- 💾 **자동 세션** — 프로젝트 디렉터리별로 작업 공간을 복원
- 🔧 `gitsigns`와 `lazygit`을 통한 Git 통합

## 요구 사항

- **Neovim** 0.10 이상
- **git**
- **Nerd Font**(아이콘용. 터미널에 설정되어 있다고 가정합니다)
- **트루컬러 터미널**(iTerm2, WezTerm, Kitty 등) — `termguicolors`에 필요
- **ripgrep**(`rg`) — Telescope 실시간 grep에 필요
- **Node.js** — 여러 LSP 서버와 포맷터(prettier 등)가 의존

## 설치

```bash
git clone git@github.com:dofy/nvim.git ~/.config/nvim
```

그런 다음 Neovim을 실행합니다:

```bash
nvim
```

첫 실행 시 lazy.nvim이 자체적으로 부트스트랩하여 모든 플러그인을 자동으로
설치합니다. LSP 서버와 도구는 Mason이 백그라운드에서 설치합니다.

- `:Lazy`로 플러그인 설치 / 업데이트 / 정리
- `:Mason`으로 LSP 서버, 포맷터, linter 관리
- `<Space>`(leader 키)를 누르고 잠시 기다리면 사용 가능한 키바인딩이 표시됩니다
- `g?`로 키바인딩 화면 보기

## 구조

```
init.lua
├── lua/custom/core/
│   ├── options.lua     # vim.opt 설정
│   └── keymaps.lua     # 기본 키맵 (leader = <Space>)
├── lua/custom/lazy.lua # lazy.nvim 부트스트랩 + 플러그인 임포트
└── lua/custom/plugins/
    ├── init.lua        # 기본 의존성 (plenary, vim-tmux-navigator)
    ├── lsp/
    │   ├── mason.lua       # Mason + mason-lspconfig + 도구 설치기
    │   └── lspconfig.lua   # nvim-lspconfig + LspAttach 키맵
    └── *.lua           # 플러그인당 파일 하나
```

플러그인을 추가하려면 `lua/custom/plugins/`에 `<name>.lua`를 만들어 lazy.nvim의
spec 테이블을 반환하면 됩니다 — 자동으로 임포트됩니다.

## 플러그인

| 분류 | 플러그인 |
| --- | --- |
| 자동완성 | blink.cmp |
| LSP | nvim-lspconfig, mason.nvim, mason-lspconfig, mason-tool-installer |
| 구문 | nvim-treesitter, nvim-treesitter-textobjects |
| 파일과 검색 | nvim-tree, telescope.nvim |
| 포맷팅과 lint | conform.nvim, nvim-lint |
| UI | catppuccin, lualine, alpha, dressing, indent-blankline, which-key |
| 편집 | autopairs, substitute.nvim, todo-comments, trouble.nvim |
| Git | gitsigns, lazygit |
| 세션과 기타 | auto-session, wakatime |

## 키맵

leader 키는 `<Space>`입니다. 아래는 빠른 참고용입니다. `<leader>` 또는 `g`를 누르고
잠시 기다리면 `which-key`가 전체 목록을 표시합니다.

### 창과 탭

| 키 | 동작 |
| --- | --- |
| `<leader>sv` / `<leader>sh` | 수직 / 수평 분할 |
| `<leader>se` / `<leader>sx` | 분할 균등화 / 분할 닫기 |
| `<leader>to` / `<leader>tx` | 탭 열기 / 닫기 |
| `<leader>tn` / `<leader>tp` | 다음 / 이전 탭 |
| `<leader>tf` | 현재 버퍼를 새 탭에서 열기 |
| `<leader>nh` | 검색 강조 지우기 |
| `jk`(삽입 모드) | 삽입 모드 종료 |

### 검색(Telescope)과 탐색기

| 키 | 동작 |
| --- | --- |
| `<leader>ff` | 현재 디렉터리에서 파일 찾기 |
| `<leader>fr` | 최근 파일 |
| `<leader>fs` | 현재 디렉터리에서 실시간 grep |
| `<leader>fc` | 커서 아래 문자열 grep |
| `<leader>ft` | todo 찾기 |
| `<leader>ee` | 파일 탐색기 토글 |
| `<leader>ef` | 현재 파일에 대해 탐색기 토글 |
| `<leader>ec` / `<leader>er` | 탐색기 접기 / 새로고침 |

### LSP

| 키 | 동작 |
| --- | --- |
| `gd` / `gR` | 정의 / 참조 |
| `gD` / `gi` / `gt` | 선언 / 구현 / 타입 정의 |
| `K` | 호버 문서 |
| `<leader>ca` | 코드 액션 |
| `<leader>rn` | 심볼 이름 변경 |
| `<leader>d` / `<leader>D` | 라인 / 파일 진단 |
| `[d` / `]d` | 이전 / 다음 진단 |
| `<leader>rs` | LSP 재시작 |

### 편집

| 키 | 동작 |
| --- | --- |
| `s` + 모션 / `ss` / `S` | 모션 / 라인 / 라인 끝까지 치환 |
| `s`(visual) | 선택 영역 치환 |
| `<leader>fo` | 파일 또는 범위 포맷 |
| `<leader>ll` | lint 실행 |
| `<leader>wr` / `<leader>ws` | 세션 복원 / 저장 |

## LSP와 포맷팅

**LSP 서버**(`mason-lspconfig`로 자동 설치): `ts_ls`, `denols`, `html`, `cssls`,
`tailwindcss`, `svelte`, `lua_ls`, `graphql`, `emmet_ls`, `prismals`, `pyright`.

**도구**(`mason-tool-installer`로 자동 설치): `prettier`, `stylua`, `isort`,
`black`, `pylint`, `eslint_d`.

**포맷팅** — `conform.nvim`, 저장 시 실행(수동: `<leader>fo`):

- JS / TS / CSS / HTML / JSON / YAML / Markdown / GraphQL → prettier
- Lua → stylua(2칸 들여쓰기)
- Python → isort + black

**Lint** — `nvim-lint`, 진입 / 저장 / 삽입 모드 종료 시 실행(수동: `<leader>ll`):

- JS / TS / Svelte → eslint_d
- Python → pylint

## 라이선스

[MIT](LICENSE)
