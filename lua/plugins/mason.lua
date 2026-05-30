return {
	{
		"mason-org/mason.nvim",

		cmd = "Mason",

		opts = {
			ui = {
				border = "rounded",
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			ensure_installed = {
				-- LSP
				"lua_ls",
				"clangd",
				"basedpyright",
				"rust_analyzer",
				"bashls",
				"jsonls",
				"yamlls",

				-- Linter
				"ruff",
			},
			automatic_enable = false,
		},
	},
}
