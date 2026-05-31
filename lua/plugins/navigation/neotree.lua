return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",

        lazy = false,

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        cmd = "Neotree",

        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
        },

        opts = {
            close_if_last_window = true,

            filesystem = {
                follow_current_file = {
                    enabled = true,
                },

                hijack_netrw_behavior = "open_default",

                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },

            window = {
                width = 30,
            },
        },
    },
}
