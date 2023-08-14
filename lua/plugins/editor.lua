return {
    -- neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = 'Neotree',
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        init = function()
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
            window = { width = 30,},
            filesystem = {
                hijack_netrw_behavior = "open_current",
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
            },
        },
       -- config = true,
    },

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                        -- the default case_mode is "smart_case"
                    }
                }
            }
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')


            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files'})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Live grep'})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Select buffers'})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Find helps'})
        end
    },



    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
            "[q",
            function()
                if require("trouble").is_open() then
                require("trouble").previous({ skip_groups = true, jump = true })
                else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
                end
            end,
            desc = "Previous trouble/quickfix item",
            },
            {
            "]q",
            function()
                if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
                else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
                end
            end,
            desc = "Next trouble/quickfix item",
            },
        },
    },
}
