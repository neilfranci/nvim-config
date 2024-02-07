local M = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
}

function M.config()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			-- python = { "isort", "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			vue = { { "prettierd", "prettier" } },
		},
	})
end

return M
