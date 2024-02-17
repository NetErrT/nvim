local plugins = {
	{
		"nvim-neo-tree/neo-tree.nvim",
		name = "neo_tree",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>fe", "<cmd>Neotree toggle<cr>" },
		},
		dependencies = {
			"devicons",
			"nui",
		},
		config = function()
			require("plugins.neo_tree")
		end
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function() require("plugins.gruvbox") end,
	},
	{
		"rcarriga/nvim-notify",
		name = "notify",
		event = { "VeryLazy" },
		config = function() require("plugins.notify") end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate" },
		keys = {
			{ "tt", "<cmd>Telescope treesitter<cr>" },
		},
		config = function() require("plugins.treesitter") end,
	},
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		cmd = { "Telescope" },
		keys = {
			{ "tf", "<cmd>Telescope find_files<cr>" },
			{ "tb", "<cmd>Telescope buffers<cr>" },
		},
		dependencies = {
			"plenary",
			"devicons",
		},
		config = function() require("plugins.telescope") end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspStart", "LspInfo" },
		config = function() require("plugins.lspconfig") end,
	},
	{
		"hrsh7th/nvim-cmp",
		name = "cmp",
		event = { "InsertEnter" },
		cmd = { "CmpStatus" },
		dependencies = {
			"luasnip",
			"cmp_luasnip",
			"cmp_lsp",
			"cmp_buffer",
		},
		config = function() require("plugins.cmp") end,
	},
	{
		"L3MON4D3/LuaSnip",
		name = "luasnip",
		dependencies = {
			"friendly_snippets",
		},
		config = function() require("plugins.luasnip") end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		name = "devicons",
		config = function() require("plugins.devicons") end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		name = "cmp_luasnip",
	},
	{
		"rafamadriz/friendly-snippets",
		name = "friendly_snippets",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		name = "cmp_lsp",
	},
	{
		"hrsh7th/cmp-buffer",
		name = "cmp_buffer",
	},
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"MunifTanjim/nui.nvim",
		name = "nui",
	},
}

local options = {
	defaults = {
		lazy = true,
	},
	change_detection = {
		enabled = false,
	},
}

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazy_path,
	})
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup(plugins, options)
