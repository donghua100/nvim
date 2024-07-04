return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
        timeout = 3000,
        background_colour = "#000000",
        stages = "slide",
    },
    config = function(_, opts)
        ---@diagnostic disable-next-line: undefined-field
        require("notify").setup(opts)
        vim.notify = require "notify"
    end,
}
