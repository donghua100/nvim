return {
	{
		"MeanderingProgrammer/render-markdown.nvim",

		ft = {
			"markdown",
			"codecompanion",
			"Avante",
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
				sign = true,
			},

			code = {
				enabled = true,

				sign = false,

				width = "block",

				border = "thin",

				position = "left",
			},

			bullet = {
				enabled = true,
			},

			quote = {
				enabled = true,
			},

			checkbox = {
				enabled = true,
			},

			pipe_table = {
				enabled = true,
			},

			latex = {
				enabled = true,
			},
		},
	},
}
