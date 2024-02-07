-- Press "/" to open search

local M = {
	"folke/flash.nvim",
	lazy = true,
	event = "BufReadPre",
	opts = {
		modes = {
			char = {
				enabled = false,
			},
			search = {
				enabled = true,
				highlight = { backdrop = true },
				jump = { history = true, register = true, nohlsearch = true },
				search = {
					multi_window = false,
				},
			},
		},
	},
}

return M
