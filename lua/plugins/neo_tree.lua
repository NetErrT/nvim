require("neo-tree").setup({
	filesystem = {
		bind_to_cwd = false,
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		use_libuv_file_watcher = true,
	},
	enable_diagnostics = false,
	popup_border_style = "rounded",
})
