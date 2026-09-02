return {
	{
		"folke/noice.nvim",

		event = "VeryLazy",

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},

		opts = {
			lsp = {
				progress = {
					enabled = true,
				},

				hover = {
					enabled = true,
				},

				signature = {
					enabled = true,
				},
			},

			presets = {
				bottom_search = true,

				command_palette = true,

				long_message_to_split = true,

				lsp_doc_border = true,
			},
		},
	},

	{
		"rcarriga/nvim-notify",

		opts = {
			timeout = 3000,
		},

		config = function(_, opts)
			local notify = require("notify")

			notify.setup(opts)

			vim.notify = notify
		end,
	},
}
