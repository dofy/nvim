-- nvim-treesitter-textobjects `main` branch.
-- The old `require("nvim-treesitter.configs").setup{ textobjects = {...} }` API
-- is gone. Now: call setup() for options, then map keys yourself to the
-- select/swap/move modules.
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local swap = require("nvim-treesitter-textobjects.swap")
    local move = require("nvim-treesitter-textobjects.move")

    -- select ------------------------------------------------------------------
    local function sel(query, group)
      return function()
        select.select_textobject(query, group or "textobjects")
      end
    end

    local select_maps = {
      ["a="] = { "@assignment.outer", "Select outer part of an assignment" },
      ["i="] = { "@assignment.inner", "Select inner part of an assignment" },
      ["l="] = { "@assignment.lhs", "Select left hand side of an assignment" },
      ["r="] = { "@assignment.rhs", "Select right hand side of an assignment" },
      ["a:"] = { "@property.outer", "Select outer part of an object property" },
      ["i:"] = { "@property.inner", "Select inner part of an object property" },
      ["l:"] = { "@property.lhs", "Select left part of an object property" },
      ["r:"] = { "@property.rhs", "Select right part of an object property" },
      ["aa"] = { "@parameter.outer", "Select outer part of a parameter/argument" },
      ["ia"] = { "@parameter.inner", "Select inner part of a parameter/argument" },
      ["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
      ["ii"] = { "@conditional.inner", "Select inner part of a conditional" },
      ["al"] = { "@loop.outer", "Select outer part of a loop" },
      ["il"] = { "@loop.inner", "Select inner part of a loop" },
      ["af"] = { "@call.outer", "Select outer part of a function call" },
      ["if"] = { "@call.inner", "Select inner part of a function call" },
      ["am"] = { "@function.outer", "Select outer part of a method/function definition" },
      ["im"] = { "@function.inner", "Select inner part of a method/function definition" },
      ["ac"] = { "@class.outer", "Select outer part of a class" },
      ["ic"] = { "@class.inner", "Select inner part of a class" },
    }
    for lhs, spec in pairs(select_maps) do
      vim.keymap.set({ "x", "o" }, lhs, sel(spec[1]), { desc = spec[2] })
    end

    -- swap --------------------------------------------------------------------
    local swap_next = {
      ["<leader>na"] = { "@parameter.inner", "Swap parameter/argument with next" },
      ["<leader>n:"] = { "@property.outer", "Swap object property with next" },
      ["<leader>nm"] = { "@function.outer", "Swap function with next" },
    }
    for lhs, spec in pairs(swap_next) do
      vim.keymap.set("n", lhs, function()
        swap.swap_next(spec[1])
      end, { desc = spec[2] })
    end

    local swap_prev = {
      ["<leader>pa"] = { "@parameter.inner", "Swap parameter/argument with prev" },
      ["<leader>p:"] = { "@property.outer", "Swap object property with prev" },
      ["<leader>pm"] = { "@function.outer", "Swap function with prev" },
    }
    for lhs, spec in pairs(swap_prev) do
      vim.keymap.set("n", lhs, function()
        swap.swap_previous(spec[1])
      end, { desc = spec[2] })
    end

    -- move --------------------------------------------------------------------
    local function mv(fn, query, group)
      return function()
        fn(query, group or "textobjects")
      end
    end

    local goto_next_start = {
      ["]f"] = { "@call.outer", "Next function call start" },
      ["]m"] = { "@function.outer", "Next method/function def start" },
      ["]c"] = { "@class.outer", "Next class start" },
      ["]i"] = { "@conditional.outer", "Next conditional start" },
      ["]l"] = { "@loop.outer", "Next loop start" },
    }
    for lhs, spec in pairs(goto_next_start) do
      vim.keymap.set({ "n", "x", "o" }, lhs, mv(move.goto_next_start, spec[1]), { desc = spec[2] })
    end
    vim.keymap.set({ "n", "x", "o" }, "]s", mv(move.goto_next_start, "@local.scope", "locals"), { desc = "Next scope" })
    vim.keymap.set({ "n", "x", "o" }, "]z", mv(move.goto_next_start, "@fold", "folds"), { desc = "Next fold" })

    local goto_next_end = {
      ["]F"] = { "@call.outer", "Next function call end" },
      ["]M"] = { "@function.outer", "Next method/function def end" },
      ["]C"] = { "@class.outer", "Next class end" },
      ["]I"] = { "@conditional.outer", "Next conditional end" },
      ["]L"] = { "@loop.outer", "Next loop end" },
    }
    for lhs, spec in pairs(goto_next_end) do
      vim.keymap.set({ "n", "x", "o" }, lhs, mv(move.goto_next_end, spec[1]), { desc = spec[2] })
    end

    local goto_prev_start = {
      ["[f"] = { "@call.outer", "Prev function call start" },
      ["[m"] = { "@function.outer", "Prev method/function def start" },
      ["[c"] = { "@class.outer", "Prev class start" },
      ["[i"] = { "@conditional.outer", "Prev conditional start" },
      ["[l"] = { "@loop.outer", "Prev loop start" },
    }
    for lhs, spec in pairs(goto_prev_start) do
      vim.keymap.set({ "n", "x", "o" }, lhs, mv(move.goto_previous_start, spec[1]), { desc = spec[2] })
    end

    local goto_prev_end = {
      ["[F"] = { "@call.outer", "Prev function call end" },
      ["[M"] = { "@function.outer", "Prev method/function def end" },
      ["[C"] = { "@class.outer", "Prev class end" },
      ["[I"] = { "@conditional.outer", "Prev conditional end" },
      ["[L"] = { "@loop.outer", "Prev loop end" },
    }
    for lhs, spec in pairs(goto_prev_end) do
      vim.keymap.set({ "n", "x", "o" }, lhs, mv(move.goto_previous_end, spec[1]), { desc = spec[2] })
    end

    -- repeatable move: ; and , (plus builtin f/F/t/T) -------------------------
    local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T_expr, { expr = true })
  end,
}
