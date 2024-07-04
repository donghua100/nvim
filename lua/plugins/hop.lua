return {
    {
        'phaazon/hop.nvim',
        event = 'VeryLazy',
        branch = 'v2', -- optional but strongly recommended
        keys = {
            { "<leader>hw", "<Cmd>HopWord<CR>", desc = "Hop Word", silent = true, noremap = true },
            { "<leader>hl", "<Cmd>HopLine<CR>", desc = "Hop Line", silent = true, noremap = true },
        },
        config = function()
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    }

}
