return {
	{
		"neovim/nvim-lspconfig",

		lazy = false,

		dependencies = {
			"saghen/blink.cmp",
		},

		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,

				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},

						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},

						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
			})

			-- vim.lsp.config("rust_analyzer", {
			-- 	capabilities = capabilities,
			-- })
			--
			-- vim.lsp.config("bashls", {
			-- 	capabilities = capabilities,
			-- })

			-- 注意：一个一个 enable
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("basedpyright")
			-- vim.lsp.enable("rust_analyzer")
			-- vim.lsp.enable("bashls")

			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = {
						buffer = event.buf,
						silent = true,
					}

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			local navic = require("nvim-navic")
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if not client then
						return
					end

					if client.server_capabilities.documentSymbolProvider then
						navic.attach(client, args.buf)
					end
				end,
			})
		end,
	},
}
