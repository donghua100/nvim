return {
	{
		"folke/snacks.nvim",

		priority = 1000,
		lazy = false,

		opts = {
			dashboard = {
				enabled = true,

				sections = {
					{
						section = "header",
					},

					{
						section = "keys",
						gap = 1,
						padding = 1,
					},

					{
						section = "startup",
						padding = 1,
					},
				},

				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.picker.files()",
					},

					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":enew",
					},

					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.picker.grep()",
					},

					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.picker.recent()",
					},

					{
						icon = " ",
						key = "p",
						desc = "Projects",
						action = ":lua Snacks.picker.projects()",
					},

					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":edit $MYVIMRC",
					},

					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
					},

					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = ":qa",
					},
				},
			},

			indent = {
				enabled = true,

				char = "│",

				scope = {
					enabled = true,
				},
			},

			explorer = {
				enabled = true,
				replace_netrw = true,
				trash = true,
			},
			-- notifier = {
			-- 	enabled = true,
			-- 	timeout = 3000,
			-- },
			-- input = {
			-- 	enabled = true,
			-- },
			terminal = {
				enabled = true,
			},

			scratch = {
				enabled = true,
			},

			bigfile = {
				enabled = true,
			},

			scroll = {
				enabled = true,
			},

			zen = {
				enabled = true,
			},

			dim = {
				enabled = true,
			},

			picker = {
				sources = {
					explorer = {
						layout = {
							preset = "sidebar",
							layout = {
								width = 30,
							},
						},
					},
				},
			},
		},
		keys = {
			-- Explorer
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			-- Picker
			-- Find Files
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},

			-- Find Text
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find Text",
			},

			-- Recent Files
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent Files",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},

			{
				"<leader>gf",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Git Files",
			},

			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},

			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help",
			},

			{
				"<leader>fk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},

			{
				"<leader>fc",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},

			{
				"<leader>fm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},

			{
				"<leader>ld",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "LSP Definitions",
			},

			{
				"<leader>lr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "LSP References",
			},

			{
				"<leader>li",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "LSP Implementations",
			},

			{
				"<leader>ls",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},

			-- 终端
			{
				"<leader>tt",
				function()
					Snacks.terminal.toggle(nil, {
						count = 1,
					})
				end,
				desc = "Terminal",
			},

			{
				"<leader>tf",
				function()
					Snacks.terminal.toggle(nil, {
						count = 2,

						win = {
							style = "float",
						},
					})
				end,
				desc = "Floating Terminal",
			},

			{
				"<leader>tl",
				function()
					local terminals = Snacks.terminal.list()

					if #terminals == 0 then
						vim.notify("No open terminals")
						return
					end

					Snacks.picker.select(terminals, {
						prompt = "Terminal",
						format_item = function(item)
							local id = vim.b[item.buf].snacks_terminal
							return string.format("Terminal %d  %s", id and id.id or 0, vim.b[item.buf].term_title or "")
						end,
					}, function(item)
						if item then
							item:show()
							item:focus()
						end
					end)
				end,
				desc = "Terminal List",
			},

			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Scratch",
			},

			{
				"<leader>uz",
				function()
					Snacks.zen()
				end,
				desc = "Zen Mode",
			},

			{
				"<leader>ud",
				function()
					if Snacks.dim.enabled then
						Snacks.dim.disable()
					else
						Snacks.dim.enable()
					end
				end,
				desc = "Dim",
			},
		},
	},
}
