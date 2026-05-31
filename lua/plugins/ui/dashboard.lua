return {
  {
    "goolord/alpha-nvim",

    event = "VimEnter",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗██╗   ██╗██╗███╗   ███╗                 ",
        "  ████╗  ██║██║   ██║██║████╗ ████║                 ",
        "  ██╔██╗ ██║██║   ██║██║██╔████╔██║                 ",
        "  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║                 ",
        "  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║                 ",
        "  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝                 ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "Find file", "<cmd>FzfLua files<cr>"),
        dashboard.button("r", "Recent files", "<cmd>FzfLua oldfiles<cr>"),
        dashboard.button("g", "Live grep", "<cmd>FzfLua live_grep<cr>"),
        dashboard.button("n", "New file", "<cmd>enew<cr>"),
        dashboard.button("l", "Lazy", "<cmd>Lazy<cr>"),
        dashboard.button("q", "Quit", "<cmd>qa<cr>"),
      }

      alpha.setup(dashboard.opts)
    end,
  },
}
