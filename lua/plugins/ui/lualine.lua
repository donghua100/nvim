return {
	{
		"nvim-lualine/lualine.nvim",

		event = "VeryLazy",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},

		opts = {
			options = {
				theme = "auto",

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
							error = "E ",
							warn = "W ",
							info = "I ",
							hint = "H ",
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

					{
						"filetype",
					},

					{
						"encoding",
					},

					{
						"fileformat",
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

			-- =====================================================
			-- Winbar
			-- =====================================================

			-- winbar = {
			--
			-- 	lualine_c = {
			-- 		{
			-- 			function()
			-- 				local filepath = vim.fn.expand("%:p")
			--
			-- 				if filepath == "" then
			-- 					return ""
			-- 				end
			--
			-- 				local relative = vim.fn.fnamemodify(filepath, ":.")
			--
			-- 				return relative:gsub("/", " › ")
			-- 			end,
			-- 		},
			-- 	},
			--
			-- 	lualine_x = {
			-- 		{
			-- 			function()
			-- 				local navic = require("nvim-navic")
			--
			-- 				if navic.is_available() then
			-- 					return navic.get_location()
			-- 				end
			--
			-- 				return ""
			-- 			end,
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
		},
	},
}
