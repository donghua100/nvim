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
    },

    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = true,
    },


    -- lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
            'folke/neoconf.nvim',
            'folke/neodev.nvim'
            -- {'williamboman/mason.nvim', dependencies = {'williamboman/mason-lspconfig.nvim'}}
        },
        config = function()
            local servers = {
                pyright = {},
                lua_ls = {},
            }
            local on_attach = function(_,bufnr)
                -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
                end
                nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
                nmap('gd', require "telescope.builtin".lsp_definitions, 'Goto Definition')
                -- nmap('gr', "<cmd>Telescope lsp_references<cr>", 'Goto Reference')
                nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('gi', require "telescope.builtin".lsp_implementations, 'Goto Implementation')
                nmap('gk', vim.lsp.buf.signature_help, 'Signature Documentation')
                nmap('gy', require'telescope.builtin'.lsp_type_definition, 'Type Definition')

                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, 'Workspace List Folders')
                nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
                nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                nmap('<leader>da', require "telescope.builtin".diagnostics, 'Diagnostics')
                -- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
                nmap("<space>f", function()
                    vim.lsp.buf.format { async = true }
                end, "Format code")
            end
            require("mason").setup()
            require("neoconf").setup()
            require("neodev").setup()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        settings = servers[server_name],
                        on_attach = on_attach,
                        capabilities = capabilities
                    }
                end,
            }
        })
        end
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            -- 'hrsh7th/cmp-cmdline',

            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require'cmp'
            local luasnip = require 'luasnip'
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),

                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'buffer'},
                    { name = 'nvim_lsp'},
                    { name = 'luasnip'},
                })
            })
        end
    }
}
