local cmp = require("cmp")
local cmp_types = require("cmp.types")
local luasnip = require("luasnip")

local compare = cmp.config.compare
local borders = cmp.config.window.bordered()
local select_behavior = cmp.SelectBehavior.Select
local confirm_behavior = cmp.ConfirmBehavior.Insert

local source_names = {
	nvim_lsp = "lsp",
	luasnip = "snip",
	buffer = "buff"
}

local icons = {
	Text = "󰉿",
	Method = "󰆧",
	Module = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Property = "󰜢",
	Variable = "󰀫",
	Class = "",
	Interface = "",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	EnumMember = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "󰈔",
	Folder = "󰉋",
	Reference = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
}

cmp.setup({
	snippet = {
		expand = function(param) luasnip.lsp_expand(param.body) end,
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			compare.score,
			compare.kind,
			compare.recently_used,
		},
	},
	window = {
		completion = borders,
		documentation = borders,
	},
	formatting = {
		fileds = { "abbr", "kind", "menu" },
		format = function(entry, item)
			item.abbr = string.sub(item.abbr, 1, 50)
			item.menu = "(" .. (source_names[entry.source.name] or "?") .. ")"
			item.kind = icons[item.kind] or "?"

			return item
		end,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = confirm_behavior,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = select_behavior })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = select_behavior })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i" })
	},
	performance = {
		max_view_entries = 30,
	},
	sources = {
		{
			name = "nvim_lsp",
			entry_filter = function(item)
				local items = cmp_types.lsp.CompletionItemKind
				local kind = item:get_kind()

				return items["Snippet"] ~= kind and items["Text"] ~= kind
			end,
			priority = 10,
		},
		{ name = "luasnip", priority = 9 },
		{ name = "buffer",  priority = 8 },
	},
})
