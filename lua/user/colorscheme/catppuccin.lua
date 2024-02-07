return {
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					gitsigns = false,
				}
			})
			vim.cmd.colorscheme("catppuccin")
		end,
}

