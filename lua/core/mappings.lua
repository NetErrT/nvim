local map = vim.keymap.set
local cmd = vim.cmd

map("n", "<S-d>", cmd.bdelete)
map("n", "<S-n>", cmd.bnext)
map("n", "<S-p>", cmd.bprevious)
