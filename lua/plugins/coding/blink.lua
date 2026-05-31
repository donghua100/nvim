return {
	{
		"saghen/blink.cmp",
		version = "1.*",

		event = "InsertEnter",

		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = {
					"accept",
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

			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
				},
			},
		},
	},
}
