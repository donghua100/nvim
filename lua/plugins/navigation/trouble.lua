return {
	{
		"folke/trouble.nvim",

		lazy = false,

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			-- 打开列表时自动预览当前项目
			auto_preview = true,

			-- 列表跟随当前选中项
			follow = true,

			-- 自动刷新诊断和列表
			auto_refresh = true,

			-- 诊断列表为空时不自动打开空窗口
			open_no_results = false,

			-- 预览显示在主编辑窗口
			preview = {
				type = "main",
			},
		},

		keys = {
			-- 工作区诊断
			{
				"<leader>xx",
				function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Diagnostics (Workspace)",
			},

			-- 当前文件诊断
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Diagnostics (Buffer)",
			},

			-- LSP 引用
			{
				"<leader>xr",
				function()
					require("trouble").toggle("lsp_references")
				end,
				desc = "LSP References",
			},

			-- 综合 LSP 导航
			{
				"<leader>xl",
				function()
					require("trouble").toggle("lsp")
				end,
				desc = "LSP Definitions / References",
			},

			-- 当前文件符号
			{
				"<leader>xs",
				function()
					require("trouble").toggle({
						mode = "symbols",
						focus = false,
					})
				end,
				desc = "Document Symbols",
			},

			-- Quickfix
			{
				"<leader>xq",
				function()
					require("trouble").toggle("qflist")
				end,
				desc = "Quickfix List",
			},

			-- Location List
			{
				"<leader>xL",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Location List",
			},
		},
	},
}
