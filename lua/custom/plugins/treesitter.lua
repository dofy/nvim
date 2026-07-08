-- nvim-treesitter `main` branch (required for Neovim 0.11+/0.12).
-- The old `master` branch API (require("nvim-treesitter.configs").setup) is gone:
--   - parsers are installed via require("nvim-treesitter").install{...}
--   - highlight/indent/folds are enabled per-buffer in a FileType autocmd
-- See: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  -- Pinned: `main` is a rolling dev branch with no releases, so :Lazy update
  -- can pull breaking API changes. Bump this commit deliberately (and keep it
  -- in sync with nvim-treesitter-textobjects), then re-test before committing.
  commit = "4916d6592ede8c07973490d9322f187e07dfefac",
  lazy = false, -- main branch does not support lazy-loading
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "graphql",
      "python",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
    }

    require("nvim-treesitter").install(ensure_installed)

    -- Enable treesitter highlight + indent + folds for installed languages.
    -- (main branch requires you to opt in per-filetype yourself.)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ensure_installed,
      callback = function(args)
        -- highlighting (provided by Neovim)
        pcall(vim.treesitter.start, args.buf)
        -- experimental treesitter indentation (provided by this plugin)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- autotag is now configured standalone (no longer via nvim-treesitter configs)
    require("nvim-ts-autotag").setup()

    -- `incremental_selection` was removed from the main branch. Reimplement the
    -- old keymaps (<C-space> to grow the selection to the parent node, <bs> to
    -- shrink) with a small stack on top of the treesitter API.
    local sel_stack = {}

    local function select_range(srow, scol, erow, ecol)
      vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
      vim.cmd("normal! v")
      vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
    end

    local function node_incremental()
      local node = vim.treesitter.get_node()
      if not node then
        return
      end
      -- when already visually selecting, climb to the first ancestor whose
      -- range is strictly larger than the node currently under the cursor
      if vim.fn.mode():match("[vV\022]") then
        local start = { node:range() }
        while node:parent() and vim.deep_equal({ node:range() }, start) do
          node = node:parent()
        end
      end
      table.insert(sel_stack, { node:range() })
      local r1, c1, r2, c2 = node:range()
      select_range(r1, c1, r2, c2)
    end

    local function node_decremental()
      table.remove(sel_stack)
      local prev = sel_stack[#sel_stack]
      if prev then
        select_range(prev[1], prev[2], prev[3], prev[4])
      end
    end

    vim.keymap.set({ "n", "x" }, "<C-space>", node_incremental, { desc = "TS: grow selection", silent = true })
    vim.keymap.set("x", "<bs>", node_decremental, { desc = "TS: shrink selection", silent = true })
  end,
}
