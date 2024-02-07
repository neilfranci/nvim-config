local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	local configs = require("nvim-treesitter.configs")
	---@diagnostic disable: missing-fields
	configs.setup({
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"c",
			"markdown",
			"markdown_inline",
			-- Web Dev
			"javascript",
			"typescript",
			"vue",
		},
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return M
