return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd[[colorscheme tokyonight-night]]
        end
    },
    { "catppuccin/nvim", name = "catppuccin"},
    { "olimorris/onedarkpro.nvim", },
    { "loctvl842/monokai-pro.nvim", },
    { 'crusoexia/vim-monokai'},
}
