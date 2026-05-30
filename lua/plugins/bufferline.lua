return {
    {
        "akinsho/bufferline.nvim",

        version = "*",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        event = "VeryLazy",

        keys = {
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>" },
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>" },
        },

        opts = {
            options = {
                diagnostics = "nvim_lsp",

                separator_style = "slant",

                always_show_bufferline = true,

                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
}
