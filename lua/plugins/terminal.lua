return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        event = 'VeryLazy',
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-t>]],
            direction = 'float',
            float_opts = {
                border = 'curved',
            },
        },
        keys = {
            {"<c-h>", '<Cmd>exe v:count1 . "ToggleTerm size=9 direction=horizontal"<CR>', desc = "Open Horizontal Terminal", silent = true, noremap = true},
            {"<leader>t", '<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', desc = "Open Float Terminal", silent = true, noremap = true},
        },
        config = true
    }
}
