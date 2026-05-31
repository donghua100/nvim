return {
  {
    "ibhagwan/fzf-lua",

    cmd = "FzfLua",

    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
    },

    opts = {
      winopts = {
        border = "rounded",
      },
    },
  },
}
