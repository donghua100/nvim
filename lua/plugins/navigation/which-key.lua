return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",

			delay = 300,

			icons = {
				mappings = true,
			},

			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>x", group = "trouble" },
				{ "<leader>c", group = "code" },
			},
		},
	},
}
