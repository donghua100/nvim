return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},

	{
		"navarasu/onedark.nvim",
		lazy = false,
	},
}
