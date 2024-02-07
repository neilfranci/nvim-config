local opt = vim.opt

-- Tab
opt.smartindent = true
opt.clipboard = "unnamedplus" -- use systtem clipboard
opt.tabstop = 2 -- number of visual spaces per TAB
opt.softtabstop = 2 -- number of spacesin tab when editing
opt.shiftwidth = 2 -- insert 2 spaces on a tab
opt.expandtab = false -- tabs are spaces, mainly because of python

-- UI Config
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.cursorline = true
opt.showmode = false
opt.mouse = "a"

-- Search
opt.smartcase = true
opt.ignorecase = true

-- opt.fileencoding = "utf-8" -- the encoding written to a file
opt.splitbelow = true
opt.splitright = true

-- always show the sign column, otherwise it would shift the text each time
opt.signcolumn = "yes"
opt.wrap = false -- display lines as one long line
opt.scrolloff = 0 -- minimal number of columns to scroll horizontally.
opt.sidescrolloff = 8 -- minimal number of screen columns

-- Won't be redrawn while executing macros, register and other commands.
-- opt.lazyredraw = false
opt.ruler = true
opt.colorcolumn = "81"
-- Set completeopt to have a better completion experience
opt.completeopt = "menu,menuone,noselect"
opt.swapfile = false
opt.backup = false
opt.cmdheight = 1
opt.showtabline = 2 -- always show tabs
opt.termguicolors = true
-- timeoutlen = 1000
opt.undofile = true
opt.updatetime = 100 -- faster completion
opt.writebackup = false
opt.laststatus = 3
opt.encoding = "utf-8"
-- Hide * markup for bold and italic, but not markers with substitutions
opt.conceallevel = 2
-- opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.list = true -- Show some invisible characters (tabs...
-- vim.o.fillchars = "diff:╱,foldopen:,foldclose:,foldsep:▕"
opt.winblend = 0
opt.pumblend = 12 -- Popup blend
opt.pumheight = 12 -- Maximum number of entries in a popup
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.winminwidth = 5 -- Minimum window width
-- opt.backspace = "indent,eol,start"
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"
--
-- opt.viewoptions:remove({ "folds" })

-- vim.cmd.colorscheme "slate"
