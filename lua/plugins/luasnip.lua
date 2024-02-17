require("luasnip").setup({
	update_events = { "TextChanged", "TextChangedI" },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
	paths = vim.fn.expand("$HOME/.config/nvim/snippets"),
})

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
