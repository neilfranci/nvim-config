local options = {
  -- Tab
  smartindent = true,
  clipboard = 'unnamedplus',   -- use systtem clipboard
  tabstop = 2,                 -- number of visual spaces per TAB
  softtabstop = 2,             -- number of spacesin tab when editing
  shiftwidth = 2,              -- insert 2 spaces on a tab
  expandtab = true,            -- tabs are spaces, mainly because of python

  -- UI Config
  number = true,
  relativenumber = true,
  numberwidth = 2,
  cursorline = true,
  showmode = false,
  mouse = "a",

  -- Search
  smartcase = true,
  ignorecase = true,

  fileencoding = "utf-8", -- the encoding written to a file
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- minimal number of columns to scroll horizontally.
  sidescrolloff = 8, -- minimal number of screen columns
  lazyredraw = false, -- Won't be redrawn while executing macros, register and other commands.
  ruler = false,
  termguicolors = true,
  -- Set completeopt to have a better completion experience,
  completeopt = 'menuone,noselect'
}

local global = {
  mapleader = " ", -- Set mapleader to space
  loaded_netrw = 1,
  loaded_netrwPlugin = 1
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

for name, value in pairs(global) do
  vim.g[name] = value
end
