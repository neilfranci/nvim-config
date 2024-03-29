local M = {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
}

function M.config()
	require("which-key").setup({})
	local mappings = {
		q = { "<cmd>confirm q<CR>", "Quit" },
		h = { name = " Harpoon" },
		v = { "<cmd>vsplit<CR>", "Split" },
		b = { name = "Buffers" },
		d = { name = "󰃤 Debug" },
		f = { name = " Find" },
		g = { name = "󰊢 Git" },
		l = {
			name = " LSP",
			b = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
		},
		p = { name = " Plugins" },
		t = { name = "󰙨 Test" },
		w = { name = "󰔚 Session" },
		[";"] = { name = " Terminal" },
		a = {
			name = "Tab",
			n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
			N = { "<cmd>tabnew %<cr>", "New Tab" },
			o = { "<cmd>tabonly<cr>", "Only" },
			h = { "<cmd>-tabmove<cr>", "Move Left" },
			l = { "<cmd>+tabmove<cr>", "Move Right" },
		},
	}

	local which_key = require("which-key")
	which_key.setup({
		window = {
			border = "rounded",
			position = "bottom",
			padding = { 2, 2, 2, 2 },
		},
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
	}

	which_key.register(mappings, opts)
end

return M
