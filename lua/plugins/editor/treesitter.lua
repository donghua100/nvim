return {
	{
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",

		event = {
			"BufReadPost",
			"BufNewFile",
		},

		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cmake",
				"lua",

				"python",
				"rust",
				"go",

				"json",
				"yaml",
				"toml",

				"markdown",
				"markdown_inline",

				"vim",
				"vimdoc",
				"query",
			},

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
				disable = {
					"c",
					"cpp",
					"rust",
				},
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
