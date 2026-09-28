return {
	{
		"kevinhwang91/nvim-ufo",

		dependencies = {
			"kevinhwang91/promise-async",
		},

		event = "BufReadPost",

		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,

			open_fold_hl_timeout = 0,

			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}

				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local suffix_width = vim.fn.strdisplaywidth(suffix)
				local target_width = width - suffix_width
				local current_width = 0

				for _, chunk in ipairs(virtText) do
					local chunk_text = chunk[1]
					local chunk_width = vim.fn.strdisplaywidth(chunk_text)

					if target_width > current_width + chunk_width then
						table.insert(newVirtText, chunk)
					else
						chunk_text = truncate(chunk_text, target_width - current_width)

						table.insert(newVirtText, {
							chunk_text,
							chunk[2],
						})

						current_width = current_width + vim.fn.strdisplaywidth(chunk_text)

						break
					end

					current_width = current_width + chunk_width
				end

				table.insert(newVirtText, {
					suffix,
					"MoreMsg",
				})

				return newVirtText
			end,
		},

		config = function(_, opts)
			require("ufo").setup(opts)

			vim.opt.foldenable = true
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99

			vim.opt.fillchars = {
				eob = " ",
				foldopen = "",
				foldclose = "",
				fold = " ",
				foldsep = " ",
				foldinner = " ",
			}
			vim.opt.foldcolumn = "auto:1"
		end,
	},
}
