return {
	{
		"nvim-neotest/neotest",

		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"rcasia/neotest-java",
				dependencies = {
					"mfussenegger/nvim-jdtls",
				},
			},
		},

		ft = {
			"java",
		},

		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-java")({
						incremental_build = true,
					}),
				},
			})
		end,

		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run test file",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({
						enter = true,
						auto_close = true,
					})
				end,
				desc = "Open test output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop test",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({
						strategy = "dap",
					})
				end,
				desc = "Debug nearest test",
			},
		},
	},
}
