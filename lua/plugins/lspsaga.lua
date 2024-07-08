return {
    {
        'nvimdev/lspsaga.nvim',
        event = "VeryLazy",
        keys = {
            {'<leader>lr', '<cmd>Lspsaga finder<cr>', desc = 'List References and Implementation', silent = true, noremap = true},
        },
        config = true,
    },
}
