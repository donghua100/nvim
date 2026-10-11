return {
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",

		opts = {
			progress = {
				display = {
					render_limit = 5,
					done_ttl = 3,
				},
			},

			notification = {
				window = {
					winblend = 0,
					relative = "editor",
				},
			},
		},
	},
}

-- https://github.com/catppuccin/nvim/discussions/323?utm_source=chatgpt.com
