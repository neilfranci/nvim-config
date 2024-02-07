local M = {
	"SmiteshP/nvim-navbuddy",
	lazy = true,
	dependencies = {
		"SmiteshP/nvim-navic",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>n",
			"<cmd>Navbuddy<cr>",
			desc = "Nav Buddy",
		},
	},
}

function M.config()
	local navbuddy = require("nvim-navbuddy")
	navbuddy.setup({
		window = {
			border = "rounded",
		},
		icons = require("user.icons").kind,
		lsp = { auto_attach = true },
	})
end

return M
