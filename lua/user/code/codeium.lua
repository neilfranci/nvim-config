local M = {
	"Exafunction/codeium.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
}

function M.config()
	require("codeium").setup({})
end

return M
