-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set
---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-----------------
-- Normal mode --
-----------------

-- Better window navigation
keymap('n', '<m-h>', '<C-w>h', opts)
keymap('n', '<m-j>', '<C-w>j', opts)
keymap('n', '<m-k>', '<C-w>k', opts)
keymap('n', '<m-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Paste but don't replace the current copy
keymap("x", "p", [["_dP]])

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)




