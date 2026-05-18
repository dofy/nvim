return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "fang2hou/blink-copilot",
    },
    build = function()
      require("blink.cmp").build():wait(60000)
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },

      snippets = { preset = "luasnip" },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          draw = {
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
            },
          },
        },
      },

      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },

      fuzzy = { implementation = "rust" },
    },
  },
}
