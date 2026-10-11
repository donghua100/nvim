return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		-- priority = 1000,
		-- opts = {},
		-- config = function()
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},

	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- },
	{
		"sainnhe/sonokai",
		lazy = false,
		-- priority = 1000,
		-- config = function()
		-- 	-- Optionally configure and load the colorscheme
		-- 	-- directly inside the plugin declaration.
		-- 	vim.g.sonokai_enable_italic = true
		-- 	vim.cmd([[colorscheme sonokai]])
		-- end,
	},
	-- 	{
	-- 		"olimorris/onedarkpro.nvim",
	-- 		priority = 1000,
	--
	-- 		config = function()
	-- 			require("onedarkpro").setup({
	-- 				styles = {
	-- 					comments = "italic",
	-- 				},
	--
	-- 				options = {
	-- 					cursorline = false,
	-- 					transparency = false,
	-- 					terminal_colors = true,
	-- 					lualine_transparency = false,
	-- 					highlight_inactive_windows = false,
	-- 				},
	-- 			})
	--
	-- 			vim.cmd.colorscheme("onedark")
	-- 		end,
	-- 	},
	-- }
	--
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,

		config = function()
			require("onedarkpro").setup({
				colors = {
					onedark = {
						breadcrumbs = "require('onedarkpro.helpers').darken('gray', 10, 'onedark')",
						codeblock = "require('onedarkpro.helpers').lighten('bg', 2, 'onedark')",
						copilot = "require('onedarkpro.helpers').darken('gray', 8, 'onedark')",
						picker_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
						picker_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
						statusline_fill = "require('onedarkpro.helpers').lighten('bg', 2, 'onedark')",
					},
				},

				highlights = {
					-- CodeCompanion
					CodeCompanionChatIcon = { fg = "${green}" },
					CodeCompanionChatToolFailure = {
						fg = "${gray}",
						italic = true,
					},
					CodeCompanionChatToolSuccess = {
						fg = "${gray}",
						bg = "NONE",
						italic = true,
					},
					CodeCompanionTokens = {
						fg = "${gray}",
						italic = true,
					},
					CodeCompanionVirtualText = {
						fg = "${gray}",
						italic = true,
					},
					CodeCompanionCodeReviewComment = {
						fg = "${cyan}",
						italic = true,
					},

					-- Markdown
					["@markup.raw.block.markdown"] = {
						bg = "${codeblock}",
					},
					["@markup.quote.markdown"] = {
						italic = true,
						extend = true,
					},

					-- Floating windows
					NormalFloat = {
						bg = "${bg}",
					},
					FloatBorder = {
						fg = "${gray}",
						bg = "${bg}",
					},

					-- Editor
					CursorLineNr = {
						bg = "${bg}",
						fg = "${fg}",
						italic = true,
					},

					MatchParen = {
						fg = "${cyan}",
					},

					ModeMsg = {
						fg = "${gray}",
					},

					Search = {
						bg = "${selection}",
						fg = "${yellow}",
						underline = true,
					},

					-- DAP
					DebugBreakpoint = {
						fg = "${red}",
						italic = true,
					},

					DebugHighlightLine = {
						fg = "${purple}",
						italic = true,
					},

					NvimDapVirtualText = {
						fg = "${cyan}",
						italic = true,
					},

					DapUIBreakpointsCurrentLine = {
						fg = "${yellow}",
						bold = true,
					},
					-- Dashboard
					SnacksDashboardDesc = { fg = "${blue}", bold = true },
					SnacksDashboardKey = { fg = "${purple}", bold = true },
					SnacksDashboardCommand = { fg = "${orange}" },

					-- Snacks Picker
					SnacksPicker = {
						bg = "${picker_results}",
					},

					SnacksPickerDir = {
						fg = "${gray}",
						italic = true,
					},

					SnacksPickerBorder = {
						fg = "${picker_results}",
						bg = "${picker_results}",
					},

					SnacksPickerListCursorLine = {
						bg = "${picker_selection}",
					},

					SnacksPickerPrompt = {
						bg = "${picker_results}",
						fg = "${purple}",
						bold = true,
					},

					SnacksPickerSelected = {
						bg = "${picker_results}",
						fg = "${orange}",
					},

					SnacksPickerTitle = {
						bg = "${purple}",
						fg = "${picker_results}",
						bold = true,
					},

					SnacksPickerTree = {
						bg = "${picker_results}",
					},

					SnacksPickerToggle = {
						bg = "${purple}",
						fg = "${picker_results}",
						italic = true,
					},

					SnacksPickerTotals = {
						bg = "${picker_results}",
						fg = "${purple}",
						bold = true,
					},

					SnacksPickerUnselected = {
						bg = "${picker_results}",
					},

					SnacksPickerPreview = {
						bg = "${bg}",
					},

					SnacksPickerPreviewBorder = {
						fg = "${bg}",
						bg = "${bg}",
					},

					SnacksPickerPreviewTitle = {
						bg = "${green}",
						fg = "${bg}",
						bold = true,
					},
				},

				plugins = {
					-- 使用 OneDarkPro 内置支持
					snacks = true,
					trouble = true,
					blink_cmp = true,
					codecompanion = true,
					nvim_navic = true,
					nvim_dap = true,
					nvim_lsp = true,
					render_markdown = true,
					treesitter = true,
					mason = true,

					-- 不使用的插件明确关闭
					barbar = false,
					lsp_saga = false,
					marks = false,
					polygot = false,
					startify = false,
					telescope = false,
					vim_ultest = false,
					which_key = false,
				},

				styles = {
					tags = "italic",
					methods = "bold",
					functions = "bold",
					keywords = "italic",
					comments = "italic",
					parameters = "italic",
					conditionals = "italic",
					virtual_text = "italic",
				},

				options = {
					cursorline = true,
				},

				caching = false,
				cache_path = vim.fn.stdpath("cache") .. "/onedarkpro",
			})

			vim.cmd.colorscheme("onedark")
		end,
	},
}
