return {
	{
		"RRethy/vim-illuminate",

		event = "VeryLazy",

		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},

				delay = 100,

				filetypes_denylist = {
					"NvimTree",
					"neo-tree",
					"TelescopePrompt",
					"dashboard",
					"alpha",
				},

				under_cursor = true,
			})
		end,
	},
}
