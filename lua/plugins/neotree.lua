return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
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
