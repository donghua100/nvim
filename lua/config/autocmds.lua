vim.api.nvim_create_autocmd("FileType", {
	pattern = "codecompanion",

	callback = function(args)
		vim.schedule(function()
			pcall(vim.treesitter.stop, args.buf)
		end)
	end,
})
