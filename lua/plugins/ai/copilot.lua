return {
	{
		"zbirenbaum/copilot.lua",

		cmd = "Copilot",

		event = "InsertEnter",

		opts = {
			panel = {
				enabled = false,
			},

			suggestion = {
				enabled = true,

				auto_trigger = true,

				debounce = 75,

				keymap = {
					accept = "<Tab>",
					accept_word = false,
					accept_line = false,

					next = "<M-]>",
					prev = "<M-[>",

					dismiss = "<C-]>",
				},
			},

			filetypes = {
				yaml = true,
				markdown = true,

				help = false,
				gitcommit = true,
				gitrebase = false,

				lua = true,
				python = true,
				cpp = true,
				c = true,
				go = true,
				rust = true,

				["*"] = true,
			},
		},
	},
}
