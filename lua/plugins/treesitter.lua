return {
    {
        'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            main = 'nvim-treesitter.configs',
            opts = {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "cpp", "cmake",
                                "cuda", "go", "bash", "java", "make"},
                highlight = {enable = true},
                indent = {enable = true},
            },
    }
}
