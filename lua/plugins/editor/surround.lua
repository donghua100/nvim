return {
	{
		"echasnovski/mini.surround",

		version = false,

		event = "VeryLazy",

		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
			},

			n_lines = 50,

			search_method = "cover_or_next",

			respect_selection_type = false,

			silent = false,
		},
	},
}
