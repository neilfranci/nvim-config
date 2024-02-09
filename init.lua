require("settings")
require("keymaps")
require("launch")
require("autocmds")
-- spec("user.extras.alpha")
spec("user.colorscheme.catppuccin")
-- spec "user.transparent"
spec("user.ui.devicons")
spec("user.code.treesitter")
spec("user.code.lsp-setup")
spec("user.code.cmp")
spec("user.code.schemestore")
spec("user.tool.telescope")
spec("user.tool.nvim-tree")
spec("user.tool.which-key")
spec("user.code.conform")
-- spec("user.code.nvim-lint")
spec("user.code.comment")
-- TODO: need to configure this
spec("user.ui.lualine")
spec("user.tool.harpoon")
-- TODO: need to configure this
-- spec("user.indent-line")
spec("user.git.gitsigns")
spec("user.ui.colorizer")
spec("user.ui.dressing")
spec("user.ui.fidget")
-- spec "user.extras.mini-notify" -- like fidget but with top popup
spec("user.extras.auto-session")
spec("user.code.codeium")
spec("user.tool.tabby")
-- spec("user.extras.illuminate") -- highlighting other uses of the word under the cursor
-- spec "user.extras.oil"
spec("user.extras.flash")
-- TODO: need to configure this
spec("user.ui.ufo")
spec("user.ui.statuscol")
-- spec "user.extras.eyeliner" -- same as flash but 1 line
-- spec("user.extras.neotab") -- Tabout #TODO fix this
spec("user.ui.bqf") -- Better quickfix window
spec("user.ui.modicator")
-- spec("user.extras.navbuddy") -- lsp navigation
spec("user.code.trouble")
spec("user.git.lazygit")
spec("user.tool.toggleterm")
spec("user.tool.spectre")
-- spec "user.extras.twilight"
-- weird scrolling, it should stop if we press opposite direction,
-- not keep scrolling lol
-- spec "user.extras.neoscroll"
require("lazy-setup")
