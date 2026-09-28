return {
	{
		"folke/sidekick.nvim",
		event = "VeryLazy",

		opts = {
			-- Next Edit Suggestions
			nes = {
				enabled = false,
				debounce = 100,

				-- NES 建议触发时机
				trigger = {
					events = {
						"ModeChanged i:n",
						"TextChanged",
						"User SidekickNesDone",
					},
				},

				-- 清除建议的时机
				clear = {
					events = {
						"TextChangedI",
						"InsertEnter",
					},
					esc = true,
				},
			},

			-- 保留现有 CLI 配置
			cli = {
				enabled = true,

				win = {
					layout = "right",

					split = {
						width = 0,
					},

					config = function(terminal)
						terminal.opts.split.width = math.floor(vim.o.columns * 0.35)
					end,
				},
				tools = {
					-- 自定义 Qoder CLI
					qoder = {
						cmd = { "qodercli" },
					},
					kimi = {
						cmd = { "kimi" },
					},
				},
			},
		},

		keys = {
			-- NES：跳转到下一处建议，或应用建议
			{
				"<leader>sn",
				function()
					require("sidekick").nes_jump_or_apply()
				end,
				desc = "NES: Jump or Apply",
			},

			-- 手动请求 NES 建议
			{
				"<leader>su",
				function()
					require("sidekick.nes").update()
				end,
				desc = "NES: Update",
			},

			-- 清除当前 NES 建议
			{
				"<leader>sx",
				function()
					require("sidekick.nes").clear()
				end,
				desc = "NES: Clear",
			},

			-- CLI：显示 / 隐藏
			{
				"<leader>st",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle CLI",
			},

			-- CLI：选择工具
			{
				"<leader>ss",
				function()
					require("sidekick.cli").select()
				end,
				desc = "Sidekick Select CLI",
			},

			-- CLI：关闭会话
			{
				"<leader>sd",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Sidekick Close CLI Session",
			},

			-- 发送当前上下文
			{
				"<leader>sa",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "n", "x" },
				desc = "Sidekick Send Context",
			},

			{
				"<leader>sp",
				function()
					require("sidekick.cli").prompt()
				end,
				desc = "Sidekick Prompt",
			},
		},
	},
}
