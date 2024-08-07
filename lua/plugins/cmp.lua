return {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',

            {
                "L3MON4D3/LuaSnip",
	            -- follow latest release.
	            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	            -- install jsregexp (optional!).
	            build = "make install_jsregexp"
            },
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind-nvim',
        },
        config = function()
            local cmp = require'cmp'
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'
            luasnip.config.setup {}
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({with_text = true, maxwidth = 50,       ellipsis_char = '...', show_labelDetails = true,})
                },
                -- completion = { completeopt = 'menu,menuone,noinsert' },
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
                { name = 'luasnip' },
                })
            })



            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline({ '/', '?' }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --     { name = 'buffer' }
            --     }
            -- })
            --
            -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline(':', {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({
            --     { name = 'path' }
            --     }, {
            --     { name = 'cmdline' }
            --     }),
            --     matching = { disallow_symbol_nonprefix_matching = false }
            -- })
        end
    }
}
