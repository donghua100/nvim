return {
	{
		"iamcco/markdown-preview.nvim",

		cmd = {
			"MarkdownPreviewToggle",
			"MarkdownPreview",
			"MarkdownPreviewStop",
		},

		ft = {
			"markdown",
		},

		build = "cd app && npm install",

		init = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
		end,

		keys = {
			{
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<CR>",
				ft = "markdown",
				desc = "Markdown Preview",
			},
		},
	},
}
