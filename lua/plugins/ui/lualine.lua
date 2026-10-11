return {
	{
		"nvim-lualine/lualine.nvim",

		event = "VeryLazy",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},

		opts = function()
			-- =====================================================
			-- OneDarkPro colors
			-- =====================================================

			local colors = require("onedarkpro.helpers").get_colors()

			-- =====================================================
			-- Lualine theme
			--
			-- 对应 Oli Morris mini.statusline 的配色语义：
			--
			-- Normal  -> purple
			-- Insert  -> green
			-- Visual  -> orange
			-- Replace -> green
			-- Command -> orange
			--
			-- 普通区域：
			-- fg = gray
			-- bg = statusline_fill
			-- =====================================================

			local theme = {
				normal = {
					a = {
						fg = colors.bg,
						bg = colors.purple,
						gui = "bold",
					},
					b = {
						fg = colors.purple,
						bg = colors.fg_gutter,
					},
					c = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					x = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					y = {
						fg = colors.purple,
						bg = colors.fg_gutter,
					},
					z = {
						fg = colors.bg,
						bg = colors.purple,
						gui = "bold",
					},
				},

				insert = {
					a = {
						fg = colors.bg,
						bg = colors.green,
						gui = "bold",
					},
					b = {
						fg = colors.green,
						bg = colors.fg_gutter,
					},
					c = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					x = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					y = {
						fg = colors.green,
						bg = colors.fg_gutter,
					},
					z = {
						fg = colors.bg,
						bg = colors.green,
						gui = "bold",
					},
				},

				visual = {
					a = {
						fg = colors.bg,
						bg = colors.orange,
						gui = "bold",
					},
					b = {
						fg = colors.orange,
						bg = colors.fg_gutter,
					},
					c = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					x = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					y = {
						fg = colors.orange,
						bg = colors.fg_gutter,
					},
					z = {
						fg = colors.bg,
						bg = colors.orange,
						gui = "bold",
					},
				},

				replace = {
					a = {
						fg = colors.bg,
						bg = colors.green,
						gui = "bold",
					},
					b = {
						fg = colors.green,
						bg = colors.fg_gutter,
					},
					c = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					x = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					y = {
						fg = colors.green,
						bg = colors.fg_gutter,
					},
					z = {
						fg = colors.bg,
						bg = colors.green,
						gui = "bold",
					},
				},

				command = {
					a = {
						fg = colors.bg,
						bg = colors.orange,
						gui = "bold",
					},
					b = {
						fg = colors.orange,
						bg = colors.fg_gutter,
					},
					c = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					x = {
						fg = colors.fg,
						bg = colors.bg_statusline,
					},
					y = {
						fg = colors.orange,
						bg = colors.fg_gutter,
					},
					z = {
						fg = colors.bg,
						bg = colors.orange,
						gui = "bold",
					},
				},

				inactive = {
					a = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
					b = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
					c = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
					x = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
					y = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
					z = {
						fg = colors.gray,
						bg = colors.statusline_fill,
					},
				},
			}

			-- ============================================================
			-- CodeCompanion components
			-- ============================================================

			local function is_codecompanion()
				return vim.bo.filetype == "codecompanion"
			end

			local function get_chat_metadata()
				if not is_codecompanion() then
					return nil
				end

				local metadata = _G.codecompanion_chat_metadata
				if not metadata then
					return nil
				end

				return metadata[vim.api.nvim_get_current_buf()]
			end

			local function get_context()
				local context = _G.codecompanion_current_context

				if not context then
					return nil
				end

				if not vim.api.nvim_buf_is_valid(context) then
					return nil
				end

				local name = vim.api.nvim_buf_get_name(context)

				if name == "" then
					return nil
				end

				return vim.fn.fnamemodify(name, ":t")
			end

			-- ------------------------------------------------------------
			-- Runtime state
			-- ------------------------------------------------------------

			local codecompanion_state = {
				requesting = false,
				tool_approval = false,
				spinner_index = 1,
			}

			local spinner_symbols = {
				"⠋",
				"⠙",
				"⠹",
				"⠸",
				"⠼",
				"⠴",
				"⠦",
				"⠧",
				"⠇",
				"⠏",
			}

			-- ------------------------------------------------------------
			-- Autocmds
			-- ------------------------------------------------------------

			local group = vim.api.nvim_create_augroup("dotfiles.codecompanion.lualine", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequest*",
				group = group,

				callback = function(args)
					if args.match == "CodeCompanionRequestStarted" then
						codecompanion_state.requesting = true
					elseif args.match == "CodeCompanionRequestFinished" then
						codecompanion_state.requesting = false
					end

					vim.cmd("redrawstatus")
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionToolApproval*",
				group = group,

				callback = function(args)
					if args.match == "CodeCompanionToolApprovalRequested" then
						codecompanion_state.tool_approval = true
					elseif args.match == "CodeCompanionToolApprovalFinished" then
						codecompanion_state.tool_approval = false
					end

					vim.cmd("redrawstatus")
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = {
					"CodeCompanionChatOpened",
					"CodeCompanionRequestFinished",
					"CodeCompanionContextChanged",
				},

				group = group,

				callback = function()
					vim.cmd("redrawstatus")
				end,
			})

			-- ============================================================
			-- 1. Request
			-- ============================================================

			local CodeCompanionRequest = require("lualine.component"):extend()

			function CodeCompanionRequest:update_status()
				if not codecompanion_state.requesting then
					return ""
				end

				codecompanion_state.spinner_index = (codecompanion_state.spinner_index % #spinner_symbols) + 1

				return spinner_symbols[codecompanion_state.spinner_index]
			end

			-- ============================================================
			-- 2. Tool Approval
			-- ============================================================

			local CodeCompanionApproval = require("lualine.component"):extend()

			function CodeCompanionApproval:update_status()
				if not codecompanion_state.tool_approval then
					return ""
				end

				return "󰘚"
			end

			-- ============================================================
			-- 3. Context
			-- ============================================================

			local CodeCompanionContext = require("lualine.component"):extend()

			function CodeCompanionContext:update_status()
				if codecompanion_state.requesting then
					return ""
				end

				local metadata = get_chat_metadata()

				if not metadata then
					return ""
				end

				local context = get_context()

				if not context then
					return ""
				end

				return " " .. context
			end

			-- ============================================================
			-- 4. Model
			-- ============================================================

			local CodeCompanionModel = require("lualine.component"):extend()

			function CodeCompanionModel:update_status()
				if codecompanion_state.requesting then
					return ""
				end

				local metadata = get_chat_metadata()

				if not metadata then
					return ""
				end

				if not metadata.adapter then
					return ""
				end

				local model = metadata.adapter.model

				if not model or model == "" then
					return ""
				end

				return " " .. model
			end

			-- ============================================================
			-- 5. Tokens
			-- ============================================================

			local CodeCompanionTokens = require("lualine.component"):extend()

			function CodeCompanionTokens:update_status()
				local metadata = get_chat_metadata()

				if not metadata then
					return ""
				end

				if not metadata.tokens or metadata.tokens <= 0 then
					return ""
				end

				return "󰔖 " .. metadata.tokens
			end

			-- ============================================================
			-- 6. Cycles
			-- ============================================================

			local CodeCompanionCycles = require("lualine.component"):extend()

			function CodeCompanionCycles:update_status()
				local metadata = get_chat_metadata()

				if not metadata then
					return ""
				end

				if not metadata.cycles or metadata.cycles <= 0 then
					return ""
				end

				return " " .. metadata.cycles
			end

			return {
				options = {
					theme = theme,

					-- 所有窗口共用一个 statusline
					globalstatus = true,

					-- 更接近现代 IDE 的扁平风格
					component_separators = {
						left = "│",
						right = "│",
					},

					section_separators = {
						left = "",
						right = "",
					},

					disabled_filetypes = {
						statusline = {
							"dashboard",
							"alpha",
							"neo-tree",
						},

						winbar = {
							"dashboard",
							"alpha",
							"neo-tree",
						},
					},
				},

				-- =====================================================
				-- Statusline
				-- =====================================================

				sections = {

					-- 当前编辑模式
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:upper()
							end,
						},
					},

					-- Git / Diagnostics
					lualine_b = {
						{
							"branch",
							icon = "󰘳",
						},

						{
							"diff",
							colored = true,

							diff_color = {
								added = {
									fg = colors.green,
								},
								modified = {
									fg = colors.yellow,
								},
								removed = {
									fg = colors.red,
								},
							},
							symbols = {
								added = "+",
								modified = "~",
								removed = "-",
							},
						},

						{
							"diagnostics",
							sources = {
								"nvim_diagnostic",
							},

							symbols = {
								error = "󰅚 ",
								warn = "󰀪 ",
								info = "󰋽 ",
								hint = "󰌶 ",
							},
						},
					},

					-- 当前文件
					lualine_c = {
						{
							"filename",

							path = 0,

							symbols = {
								modified = " ●",
								readonly = " ",
								unnamed = "[No Name]",
							},
						},
					},

					-- 文件类型 / 编码
					lualine_x = {

						{ "filetype" },
						{ "encoding" },
						{ "fileformat" },

						{
							CodeCompanionRequest,
							color = { fg = colors.yellow },
						},

						{
							CodeCompanionApproval,
							color = { fg = colors.red },
						},

						{
							CodeCompanionContext,
							color = { fg = colors.gray },
						},

						{
							CodeCompanionTokens,
							color = { fg = colors.gray },
						},
						{
							CodeCompanionCycles,
							color = { fg = colors.gray },
						},
						{
							CodeCompanionModel,
							color = { fg = colors.purple },
						},
					},

					-- 当前文件进度
					lualine_y = {
						{
							"progress",
						},
					},

					-- 行列
					lualine_z = {
						{
							"location",
						},
					},
				},

				-- tabline = {
				-- 	lualine_a = {
				-- 		{
				-- 			"buffers",
				-- 			show_filename_only = true,
				-- 			mode = 2,
				-- 		},
				-- 	},
				--
				-- 	lualine_z = {
				-- 		{
				-- 			"tabs",
				-- 			mode = 2,
				-- 		},
				-- 	},
				-- },

				winbar = {
					lualine_c = {
						{
							function()
								local filepath = vim.fn.expand("%:p")

								if filepath == "" then
									return ""
								end

								local relative = vim.fn.fnamemodify(filepath, ":.")

								local path = relative:gsub("/", " › ")

								local navic = require("nvim-navic")

								if navic.is_available() then
									local location = navic.get_location()

									if location ~= "" then
										return path .. " › " .. location
									end
								end

								return path
							end,
						},
					},
				},

				inactive_winbar = {
					lualine_c = {
						{
							function()
								local filepath = vim.fn.expand("%:p")

								if filepath == "" then
									return ""
								end

								local relative = vim.fn.fnamemodify(filepath, ":.")

								return relative:gsub("/", " › ")
							end,
						},
					},
				},
			}
		end,
	},
}
