return {
	{
		"mfussenegger/nvim-lint",

		-- 插件什么时候加载
		event = {
			"BufReadPost",
			"BufNewFile",
		},

		opts = {
			-- lint 什么时候执行
			events = {
				"BufWritePost",
				"BufReadPost",
				"InsertLeave",
			},

			linters_by_ft = {
				python = {
					"ruff",
				},

				c = {
					"clangtidy",
				},

				cpp = {
					"clangtidy",
				},
			},
		},

		config = function(_, opts)
			local lint = require("lint")

			-- 配置不同文件类型使用什么 linter
			lint.linters_by_ft = opts.linters_by_ft

			-- 创建自己的 autocmd group
			local group = vim.api.nvim_create_augroup("nvim-lint", {
				clear = true,
			})

			-- 自动 lint
			vim.api.nvim_create_autocmd(opts.events, {
				group = group,

				callback = function()
					vim.defer_fn(function()
						lint.try_lint()
					end, 100)
				end,
			})
		end,
	},
}
