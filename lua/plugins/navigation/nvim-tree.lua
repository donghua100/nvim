vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		cmd = {
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeToggle",
			"NvimTreeFocus",
			"NvimTreeFindFile",
			"NvimTreeRefresh",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("nvim-tree.api").tree.toggle()
				end,
				desc = "File Explorer",
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			view = {
				side = "left",
				width = 32,
			},

			actions = {
				open_file = {
					quit_on_open = true,
				},
			},

			renderer = {
				-- 压缩连续的单子目录链
				group_empty = true,

				indent_markers = {
					enable = true,
				},
			},

			filters = {
				dotfiles = true,
				git_ignored = true,
			},

			git = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},

			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},

			update_focused_file = {
				enable = true,
				update_root = false,
			},

			on_attach = "default",

			hijack_directories = {
				enable = true,
				auto_open = false,
			},
		},
	},
}
