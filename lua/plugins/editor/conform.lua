return {
	{
		"stevearc/conform.nvim",

		event = {
			"BufWritePre",
		},

		opts = {
			formatters_by_ft = {
				lua = { "stylua" },

				python = { "black" },

				-- JDTLS imports Maven/Gradle project settings and provides Java formatting.
				java = { lsp_format = "prefer" },

				c = { "clang-format" },
				cpp = { "clang-format" },

				go = { "gofmt" },

				rust = { "rustfmt" },

				sh = { "shfmt" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
					},
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
