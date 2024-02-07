-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

local keymap = vim.keymap.set
---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-----------------
-- Normal mode --
-----------------

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<m-j>", "<C-w>j", { desc = "Go to down window", remap = true })
keymap("n", "<m-k>", "<C-w>k", { desc = "Go to up window", remap = true })
keymap("n", "<m-l>", "<C-w>l", { desc = "Go to right window", remap = true })

keymap("n", "<m-Left>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<m-Down>", "<C-w>j", { desc = "Go to down window", remap = true })
keymap("n", "<m-Up>", "<C-w>k", { desc = "Go to up window", remap = true })
keymap("n", "<m-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize with arrows
-- delta: 2 lines
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste but don't replace the current copy
keymap("x", "p", [["_dP]])

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
