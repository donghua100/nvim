return {
    -- colorscheme
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd[[colorscheme tokyonight]]
        end
    },


    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = 
        {
            theme = 'tokoynight',
            -- theme = 'dracula',
            disabled_filetypes = {
                'neo-tree',
            },
        },
        config = true,
    },

    -- bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        config = true,
    },
    -- indent blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = true,
    },

    -- dashboard
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end

    },

    {
        "echasnovski/mini.indentscope",
        -- version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
            })
        end,
    },

    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },

}
