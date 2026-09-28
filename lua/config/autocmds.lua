vim.api.nvim_create_autocmd("FileType", {
	pattern = "codecompanion",

	callback = function(args)
		vim.schedule(function()
			pcall(vim.treesitter.stop, args.buf)
		end)
	end,
})

-- vim.diagnostic.config({
-- 	signs = {
-- 		text = {
-- 			[vim.diagnostic.severity.ERROR] = "󰅚",
-- 			[vim.diagnostic.severity.WARN] = "󰀪",
-- 			[vim.diagnostic.severity.INFO] = "󰋽",
-- 			[vim.diagnostic.severity.HINT] = "󰌶",
-- 		},
-- 	},
-- })
