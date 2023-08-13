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



}
