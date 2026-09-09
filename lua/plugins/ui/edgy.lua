return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",

		-- keys = {
		-- 	{
		-- 		"<leader>ue",
		-- 		function()
		-- 			require("edgy").toggle()
		-- 		end,
		-- 		desc = "Edgy Toggle",
		-- 	},
		-- },

		opts = {
			bottom = {
				{
					ft = "qf",
					title = "QuickFix",
				},
			},
		},
	},
}
