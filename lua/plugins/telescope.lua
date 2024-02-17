local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = "close",
			},
		},
	},
})

telescope.load_extension("notify")
