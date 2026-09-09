return {
	{
		"saghen/blink.cmp",
		version = "1.*",

		event = "InsertEnter",

		dependencies = {
			"L3MON4D3/LuaSnip",
		},

		opts = {
			keymap = {
				preset = "default",

				["<CR>"] = {
					"accept",
					"fallback",
				},

				["<Tab>"] = {
					"snippet_forward",
					"select_next",
					"fallback",
				},

				["<S-Tab>"] = {
					"snippet_backward",
					"select_prev",
					"fallback",
				},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},

				menu = {
					auto_show = true,
				},

				documentation = {
					auto_show = true,
				},
			},

			snippets = {
				preset = "luasnip",
			},

			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
			},
		},
	},
}
