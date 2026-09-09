return {
	{
		"MeanderingProgrammer/render-markdown.nvim",

		ft = {
			"markdown",
			"codecompanion",
		},

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			render_modes = true,
			restart_highlighter = false,
			injections = {
				enabled = false,
			},

			heading = {
				enabled = true,
			},

			code = {
				enabled = true,

				sign = false,

				width = "block",

				border = "thin",
			},

			bullet = {
				enabled = true,
			},

			quote = {
				enabled = true,
			},
		},
	},
}
