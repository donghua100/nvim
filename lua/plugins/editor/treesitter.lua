return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",

		lazy = false,

		opts = {
			ensure_installed = {
				"bash",
				"java",
				"c",
				"cpp",
				"cmake",
				"lua",

				"python",
				"rust",
				"go",

				"json",
				"yaml",
				"toml",

				"markdown",
				"markdown_inline",

				"vim",
				"vimdoc",
				"query",
			},
		},

		config = function(_, opts)
			-- 安装 parser
			require("nvim-treesitter").install(opts.ensure_installed)

			-- 启用 Treesitter
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)

					if lang then
						local ok = pcall(vim.treesitter.start, args.buf, lang)

						if not ok then
							return
						end
					end
				end,
			})
		end,
	},
}
