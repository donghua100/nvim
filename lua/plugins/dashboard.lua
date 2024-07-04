return {
    -- 'goolord/alpha-nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- config = function ()
    --     require'alpha'.setup(require'alpha.themes.dashboard'.config)
    -- end
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
        local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]]
        logo = string.rep("\n", 8) .. logo .. "\n\n"
        local opts = {
            theme = "doom",
            config = {
                -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=neovim
                header = vim.split(logo, "\n"),
                center = {
                    { action = "Telescope find_files",                                                  desc = " Find File",       icon = " ", key = "f" },
                    { action = "ene | startinsert",                                                     desc = " New File",        icon = " ", key = "n" },
                    { action = "Telescope oldfiles",                                                    desc = " Recent Files",    icon = " ", key = "r" },
                    { action = "Telescope live_grep",                                                   desc = " Find Text",       icon = " ", key = "g" },
                    { action = 'lua require("telescope.builtin").colorscheme({enable_preview = true})', desc = " Colorscheme",     icon = " ", key = "c" },
                    -- { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
                    { action = "Mason",                                                                  desc = " Mason",           icon = " ", key = "x" },
                    { action = "Lazy",                                                                   desc = " Lazy",            icon = "󰒲 ", key = "l" },
                    { action = function() vim.api.nvim_input("<cmd>qa<cr>") end,                         desc = " Quit",            icon = " ", key = "q" },
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                end,
            },
        }
        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end
        return opts
    end
}
