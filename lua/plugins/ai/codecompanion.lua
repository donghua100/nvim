return {
	{
		"olimorris/codecompanion.nvim",
		event = "VeryLazy",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ibhagwan/fzf-lua",
		},

		opts = {
			-- HTTP 模型适配器
			adapters = {
				http = {
					opts = {
						show_model_choices = false,
					},

					-- OpenAI
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "OPENAI_API_KEY",
							},
							schema = {
								model = {
									default = "gpt-5",
								},
							},
						})
					end,

					-- 通义千问：DashScope OpenAI 兼容接口
					qwen = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "DASHSCOPE_API_KEY",
							},
							url = "https://dashscope.aliyuncs.com/compatible-mode/v1",
							schema = {
								model = {
									default = "qwen3-max",
								},
							},
						})
					end,

					-- DeepSeek：通过SCNET API 兼容接口调用
					scnet_deepseek = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "SCNET_API_KEY",
							},
							url = "https://api.scnet.cn/api/llm/v1/chat/completions",
							schema = {
								model = {
									default = "DeepSeek-V4.1-Flash",
								},
							},
						})
					end,

					nvidia_deepseek = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "NVIDIA_API_KEY",
							},
							url = "https://integrate.api.nvidia.com/v1",
							schema = {
								model = {
									default = "deepseek-ai/deepseek-v4.1-flash",
								},
							},
						})
					end,
					openrouter = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "OPENROUTER_API_KEY",
							},
							url = "https://openrouter.ai/api/v1/",
							schema = {
								model = {
									default = "nvidia/nemotron-3-ultra-550b-a55b:free",
								},
							},
						})
					end,
				},
			},

			-- 新版使用 interactions，不再使用 strategies
			interactions = {
				chat = {
					adapter = "scnet_deepseek",
				},

				inline = {
					adapter = "scnet_deepseek",
				},

				-- CodeCompanion 的 CLI 交互
				-- 这里配置的是 CodeCompanion 自己管理的 Codex CLI，
				-- 与 Sidekick 的 CLI 窗口不是同一个入口。
				cli = {
					agent = "opencode",
					agents = {
						codex = {
							cmd = "codex",
							args = {},
							description = "OpenAI Codex CLI",
							provider = "terminal",
						},
						opencode = {
							cmd = "opencode",
							args = {},
							description = "OpenCode CLI",
							provider = "terminal",
						},
					},
				},
			},

			display = {
				action_palette = {
					provider = "snacks",
				},

				chat = {
					show_token_count = false,
					show_settings = false,
					start_in_insert_mode = false,

					window = {
						layout = "vertical",
						width = 0.45,
						border = "rounded",
					},
				},
			},
		},

		config = function(_, opts)
			require("codecompanion").setup(opts)

			-- 如果 CodeCompanion 聊天缓冲区的 Treesitter 高亮有问题，
			-- 再考虑保留这个 workaround；默认先不主动停止 Treesitter。
			local map = vim.keymap.set

			-- map("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", {
			-- 	desc = "AI Chat",
			-- })
			-- map("v", "<leader>cc", "<cmd>CodeCompanionChat<cr>", {
			-- 	desc = "AI Chat",
			-- })

			map("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", {
				desc = "AI Chat Toggle",
			})

			map("v", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", {
				desc = "AI Chat Toggle",
			})

			map("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", {
				desc = "AI Actions",
			})
			map("v", "<leader>ca", "<cmd>CodeCompanionActions<cr>", {
				desc = "AI Actions",
			})

			map("n", "<leader>ci", "<cmd>CodeCompanion<cr>", {
				desc = "AI Inline",
			})
			-- map("v", "<leader>ci", "<cmd>CodeCompanion<cr>", {
			-- 	desc = "AI Inline",
			-- })
			map("v", "<leader>ci", ":CodeCompanion ", {
				desc = "AI Inline",
			})

			map("n", "<leader>cx", "<cmd>CodeCompanionCLI agent=opencode<cr>", {
				desc = "CodeCompanion Codex CLI",
			})
		end,
	},
}
