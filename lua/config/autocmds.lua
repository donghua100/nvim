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

-- Open nvim-tree when Neovim starts with a directory.
local function open_nvim_tree(data)
	-- Only handle directory startup arguments.
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- Create a new, empty buffer.
	vim.cmd.enew()

	-- Wipe the original directory buffer.
	vim.cmd.bw(data.buf)

	-- Change the working directory.
	vim.cmd.cd(data.file)

	-- Open nvim-tree.
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeStartup", {
		clear = true,
	}),
	callback = open_nvim_tree,
})
