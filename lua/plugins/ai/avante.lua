return {
    {
        "yetone/avante.nvim",

        event = "VeryLazy",

        version = false,

        build = "make",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            -- Avante required dependencies
            {
                "ColinKennedy/mega.cmdparse",
                dependencies = {
                    "ColinKennedy/mega.logging",
                },
            },
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            "folke/snacks.nvim",
        },

        opts = {
            ------------------------------------------------------------------
            -- Provider
            ------------------------------------------------------------------

            -- 默认 Provider
            provider = "SCNET",
            auto_suggestions_provider = "SCNET",

            mode = "agentic",

            ------------------------------------------------------------------
            -- Providers
            ------------------------------------------------------------------

            providers = {
                ----------------------------------------------------------------
                -- OpenRouter
                ----------------------------------------------------------------

                openrouter = {
                    __inherited_from = "openai",

                    endpoint = "https://openrouter.ai/api/v1",

                    api_key_name = "OPENROUTER_API_KEY",

                    model = "nvidia/nemotron-3-ultra-550b-a55b:free",

                    timeout = 30000,
                },

                ----------------------------------------------------------------
                -- SCNET
                ----------------------------------------------------------------

                SCNET = {
                    __inherited_from = "openai",

                    endpoint = "https://api.scnet.cn/api/llm/v1",

                    api_key_name = "SCNET_API_KEY",

                    model = "DeepSeek-V4.1-Flash",

                    timeout = 30000,
                },

                ----------------------------------------------------------------
                -- NVIDIA
                ----------------------------------------------------------------

                NVIDIA = {
                    __inherited_from = "openai",

                    endpoint = " https://integrate.api.nvidia.com/v1",

                    api_key_name = "NVIDIA_API_KEY",

                    model = "deepseek-ai/deepseek-v4.1-flash",

                    timeout = 30000,
                },
                ----------------------------------------------------------------
                -- SiliconFlow
                ----------------------------------------------------------------

                -- siliconflow = {
                -- 	__inherited_from = "openai",
                --
                -- 	endpoint = "https://api.siliconflow.cn/v1",
                --
                -- 	api_key_name = "SILICONFLOW_API_KEY",
                --
                -- 	model = "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                --
                -- 	timeout = 30000,
                -- },
                --
                -- ----------------------------------------------------------------
                -- -- OpenAI
                -- ----------------------------------------------------------------
                --
                -- openai = {
                -- 	__inherited_from = "openai",
                --
                -- 	endpoint = "https://api.openai.com/v1",
                --
                -- 	api_key_name = "OPENAI_API_KEY",
                --
                -- 	model = "gpt-5",
                --
                -- 	timeout = 30000,
                -- },
            },

            ------------------------------------------------------------------
            -- Behaviour
            ------------------------------------------------------------------

            behaviour = {
                -- 不启用 AI 自动补全
                -- 避免和 blink.cmp / Copilot 冲突
                auto_suggestions = false,

                auto_set_highlight_group = true,

                auto_set_keymaps = true,

                -- 不自动应用 AI 生成的 diff
                auto_apply_diff_after_generation = false,

                minimize_diff = true,

                enable_token_counting = true,

                -- 自动将当前文件加入上下文
                auto_add_current_file = true,

                -- Agentic 模式下，工具权限不要全部自动批准
                auto_approve_tool_permissions = false,
                confirmation_ui_style = "popup",
            },

            ------------------------------------------------------------------
            -- Windows
            ------------------------------------------------------------------

            windows = {
                position = "right",

                wrap = true,

                width = 30,

                sidebar_header = {
                    enabled = true,
                    align = "center",
                    rounded = true,
                },

                input = {
                    height = 8,
                },

                edit = {
                    border = "rounded",
                },

                ask = {
                    floating = false,
                    start_insert = true,
                    border = "rounded",
                },
            },

            ------------------------------------------------------------------
            -- Input
            ------------------------------------------------------------------

            input = {
                provider = "snacks",

                provider_opts = {
                    title = "Avante Input",
                    icon = " ",
                },
            },

            ------------------------------------------------------------------
            -- Selector
            ------------------------------------------------------------------

            selector = {
                provider = "snacks",
            },

            ------------------------------------------------------------------
            -- File selector
            ------------------------------------------------------------------

            file_selector = {
                provider = "snacks",
            },

            ------------------------------------------------------------------
            -- Instructions
            ------------------------------------------------------------------

            instructions_file = "avante.md",
        },

        config = function(_, opts)
            require("avante").setup(opts)

            local function set_avante_highlights()
                -- Avante 侧栏内部的分隔线
                vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", {
                    fg = "#7aa2f7",
                    bg = "NONE",
                })

                -- Avante 输入框边框
                vim.api.nvim_set_hl(0, "AvantePromptInputBorder", {
                    fg = "#7aa2f7",
                    bg = "NONE",
                })

                -- 浮动窗口边框
                vim.api.nvim_set_hl(0, "FloatBorder", {
                    fg = "#7aa2f7",
                    bg = "NONE",
                })

                -- 窗口之间的普通分隔线
                vim.api.nvim_set_hl(0, "WinSeparator", {
                    fg = "#565f89",
                    bg = "NONE",
                })
                vim.api.nvim_set_hl(0, "AvanteTitle", {
                    fg = "#c0caf5",
                    bg = "#292e42",
                    bold = true,
                })

                vim.api.nvim_set_hl(0, "AvanteSubtitle", {
                    fg = "#7aa2f7",
                    bold = true,
                })

                vim.api.nvim_set_hl(0, "AvanteThirdTitle", {
                    fg = "#e0af68",
                    bold = true,
                })
            end

            set_avante_highlights()

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = set_avante_highlights,
            })
        end,
    },
}
