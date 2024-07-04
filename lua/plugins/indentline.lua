return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            exclude = {
                filetypes = {
                    "dashboard",
                    "terminal",
                    "log",
                    "lsp-installer",
                    "lspinfo",
                },
            },
        },
        config = true,
    },

    {
       'echasnovski/mini.indentscope',
        version = '*',
        config = true,
    },

}
