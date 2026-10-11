return {
	{
		"olimorris/codecompanion.nvim",
		event = "VeryLazy",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ibhagwan/fzf-lua",
			"j-hui/fidget.nvim",
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
									default = "DeepSeek-V4.1-Flash-Event",
								},
							},
						})
					end,

					nvidia_deepseek = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "NVIDIA_API_KEY",
							},
							url = "https://integrate.api.nvidia.com/v1/chat/completions",
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
							url = "https://openrouter.ai/api/v1/chat/completions",
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
					adapter = "openrouter",
					sessions = {
						enabled = true,
						autosave = true,
						continuous_save = true,
						save_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "codecompanion", "sessions"),
					},
				},

				inline = {
					adapter = "openrouter",
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
					intro_message = "AI Assistant",
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

			-- ============================================================
			-- CodeCompanion → Fidget
			-- ============================================================

			local ok, progress = pcall(require, "fidget.progress")

			if not ok then
				vim.notify("Fidget.nvim is not available", vim.log.levels.WARN)
				return
			end

			local spinner_messages = {
				request = {
					started = "  Sending...",
					success = "  Completed",
					error = "  Failed",
					cancelled = "󰜺  Cancelled",
				},

				judge = {
					started = "  Checking...",
					success = "󰕥  Checked",
					error = "󰦞  Check Failed",
					cancelled = "󰜺  Cancelled",
				},
			}

			local function format_adapter(adapter)
				if not adapter then
					return "CodeCompanion"
				end

				if adapter.model and adapter.model ~= "" then
					return adapter.formatted_name .. " (" .. adapter.model .. ")"
				end

				return adapter.formatted_name
			end

			local spinner_events = {
				{
					started = "CodeCompanionRequestStarted",
					finished = "CodeCompanionRequestFinished",
					messages = spinner_messages.request,

					client_name = function(data)
						return format_adapter(data.adapter)
					end,
				},

				{
					started = "CodeCompanionToolsJudgeStarted",
					finished = "CodeCompanionToolsJudgeFinished",
					messages = spinner_messages.judge,

					client_name = function(data)
						return data.tool or "CodeCompanion"
					end,
				},
			}

			local handles = {}

			local group = vim.api.nvim_create_augroup("dotfiles.codecompanion.fidget", { clear = true })

			for _, event in ipairs(spinner_events) do
				vim.api.nvim_create_autocmd("User", {
					pattern = event.started,
					group = group,

					callback = function(args)
						local data = args.data

						if not data or not data.id then
							return
						end

						if handles[data.id] then
							return
						end

						handles[data.id] = progress.handle.create({
							title = "",
							message = event.messages.started,

							lsp_client = {
								name = event.client_name(data),
							},
						})
					end,
				})

				vim.api.nvim_create_autocmd("User", {
					pattern = event.finished,
					group = group,

					callback = function(args)
						local data = args.data

						if not data or not data.id then
							return
						end

						local handle = handles[data.id]
						handles[data.id] = nil

						if not handle then
							return
						end

						local status = data.status or "cancelled"

						handle.message = event.messages[status] or event.messages.cancelled

						handle:finish()
					end,
				})
			end
		end,
	},
}
