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

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {enable_check_bracket_line = false},
    },

    -- lsp
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
            'folke/neoconf.nvim',
            'folke/neodev.nvim',
            "SmiteshP/nvim-navic"
            -- {'williamboman/mason.nvim', dependencies = {'williamboman/mason-lspconfig.nvim'}}
        },
        event = { "BufReadPre", "BufNewFile", "InsertEnter"},
        config = function()
            local servers = {
                pyright = {},
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                    }
                },
                bashls = {},
                clangd = {},
                cmake = {},
                -- gopls = {},
                jdtls = {},
                vimls = {},
            }
            -- local navic =  require("nvim-navic")
            local on_attach = function(client,bufnr)
                -- if client.server_capabilities.documentSymbolProvider then
                --     navic.attach(client, bufnr)
                -- end
                -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    if not func then
                        print("Error: function for keymap" .. keys .. "is nil")
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
                nmap('gy', require'telescope.builtin'.lsp_type_definitions, 'Type Definition')

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
            -- navic.setup {
            --     icons = {
            --         File          = "󰈙 ",
            --         Module        = " ",
            --         Namespace     = "󰌗 ",
            --         Package       = " ",
            --         Class         = "󰌗 ",
            --         Method        = "󰆧 ",
            --         Property      = " ",
            --         Field         = " ",
            --         Constructor   = " ",
            --         Enum          = "󰕘",
            --         Interface     = "󰕘",
            --         Function      = "󰊕 ",
            --         Variable      = "󰆧 ",
            --         Constant      = "󰏿 ",
            --         String        = "󰀬 ",
            --         Number        = "󰎠 ",
            --         Boolean       = "◩ ",
            --         Array         = "󰅪 ",
            --         Object        = "󰅩 ",
            --         Key           = "󰌋 ",
            --         Null          = "󰟢 ",
            --         EnumMember    = " ",
            --         Struct        = "󰌗 ",
            --         Event         = " ",
            --         Operator      = "󰆕 ",
            --         TypeParameter = "󰊄 ",
            --     },
            --     lsp = {
            --         auto_attach = false,
            --         preference = nil,
            --     },
            --     highlight = false,
            --     separator = " > ",
            --     depth_limit = 0,
            --     depth_limit_indicator = "..",
            --     safe_output = true,
            --     lazy_update_context = false,
            --     click = false
            -- }
            -- require'lspconfig'.bashls.setup{}
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
            'hrsh7th/cmp-cmdline',
            'windwp/nvim-autopairs',

            {
                'saadparwaiz1/cmp_luasnip',
                dependencies = {
                    {'L3MON4D3/LuaSnip', build = "make install_jsregexp"},
                    "rafamadriz/friendly-snippets",
                }

            }
        },
        config = function()
            local cmp = require'cmp'
            local luasnip = require 'luasnip'
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
            require("luasnip.loaders.from_vscode").lazy_load()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end


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

                    -- tab for snippet
                    ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                            -- they way you will only jump inside the snippet region
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            elseif has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                            end, { "i", "s" }),

                            ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                            end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'buffer'},
                    { name = 'nvim_lsp'},
                    { name = 'luasnip'},
                })
            })

            -- cmp-cmdline
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                    }
                })
            })
        end
    }
}
