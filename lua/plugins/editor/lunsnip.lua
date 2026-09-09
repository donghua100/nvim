return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",

		build = "make install_jsregexp",

		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local luasnip = require("luasnip")

			luasnip.config.setup({
				history = true,
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			-- friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- 自定义 snippets
			require("luasnip.loaders.from_lua").lazy_load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})
		end,
	},
}
