local opt = vim.opt
local g = vim.g
local providers = { "python3", "ruby", "perl", "node" }

g.mapleader = " "

opt.clipboard = { "unnamedplus", "unnamed" }
opt.expandtab = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.matchpairs:append("<:>")
opt.swapfile = false
opt.wrap = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.mouse = "a"
opt.relativenumber = true
opt.scrolloff = 3
opt.sidescrolloff = 8
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.signcolumn = "yes"
opt.splitright = true
opt.termguicolors = true
opt.numberwidth = 2
opt.undofile = true
opt.virtualedit = "block"

for _, provider in ipairs(providers) do
	g["loaded_" .. provider .. "_provider"] = 0
end
