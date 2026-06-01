return {
	{
		"lewis6991/gitsigns.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			current_line_blame = false,
		},

		keys = {
			{
				"]h",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Next Hunk",
			},

			{
				"[h",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Prev Hunk",
			},

			{
				"<leader>gh",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Hunk",
			},

			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Blame Line",
			},
		},
	},
}
