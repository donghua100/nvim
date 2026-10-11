return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			-- 会话保存目录
			dir = vim.fn.stdpath("state") .. "/sessions/",

			-- 至少打开一个普通文件才自动保存
			need = 1,

			-- Git 项目按分支分别保存会话
			branch = true,
		},

		config = function(_, opts)
			require("persistence").setup(opts)

			-- 恢复当前项目的会话
			vim.keymap.set("n", "<leader>qs", function()
				require("persistence").load()
			end, { desc = "Session: Restore Current" })

			-- 选择历史会话
			vim.keymap.set("n", "<leader>qS", function()
				require("persistence").select()
			end, { desc = "Session: Select" })

			-- 恢复最近一次会话
			vim.keymap.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end, { desc = "Session: Restore Last" })

			-- 本次退出时不自动保存
			vim.keymap.set("n", "<leader>qd", function()
				require("persistence").stop()
			end, { desc = "Session: Disable Auto Save" })
		end,
	},
}
