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
			--------------------------------------------------
			-- Adapters
			--------------------------------------------------
			adapters = {
				--------------------------------------------------
				-- HTTP
				--------------------------------------------------
				http = {
					opts = {
						show_model_choices = false,
					},

					--------------------------------------------------
					-- OpenAI
					--------------------------------------------------
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

					--------------------------------------------------
					-- Qwen
					--------------------------------------------------
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

					--------------------------------------------------
					-- DeepSeek
					--------------------------------------------------
					deepseek = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "NVIDIA_API_KEY",
							},

							url = "https://integrate.api.nvidia.com/v1/chat/completions",

							schema = {
								model = {
									default = "deepseek-ai/deepseek-v4-pro",
								},
							},
						})
					end,
				},
			},

			--------------------------------------------------
			-- Strategies
			--------------------------------------------------
			strategies = {
				chat = {
					adapter = "deepseek",
				},

				inline = {
					adapter = "deepseek",
				},

				agent = {
					adapter = "deepseek",
				},
			},

			--------------------------------------------------
			-- Display
			--------------------------------------------------
			display = {
				action_palette = {
					provider = "fzf_lua",
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

			--------------------------------------------------
			-- Treesitter workaround
			--------------------------------------------------
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "codecompanion",
				callback = function()
					pcall(vim.treesitter.stop)
				end,
			})

			--------------------------------------------------
			-- Keymaps
			--------------------------------------------------
			local map = vim.keymap.set

			map("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", {
				desc = "AI Chat",
			})

			map("v", "<leader>cc", "<cmd>CodeCompanionChat<cr>", {
				desc = "AI Chat",
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

			map("v", "<leader>ci", "<cmd>CodeCompanion<cr>", {
				desc = "AI Inline",
			})

			map("n", "<leader>cx", "<cmd>CodeCompanionCLI<cr>", {
				desc = "Codex CLI",
			})
		end,
	},
}
