return {
	"kevinhwang91/nvim-ufo",
	-- event = { "BufReadPost", "BufNewFile" },
	event = "VeryLazy",
	dependencies = {
		"kevinhwang91/promise-async",
		-- "luukvbaal/statuscol.nvim",
	},
	init = function()
		local set_foldcolumn_for_file = vim.api.nvim_create_augroup("set_foldcolumn_for_file", {
			clear = true,
		})
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = set_foldcolumn_for_file,
			callback = function()
				if vim.bo.buftype == "" then
					vim.wo.foldcolumn = "1"
				else
					vim.wo.foldcolumn = "0"
				end
			end,
		})
		vim.api.nvim_create_autocmd("OptionSet", {
			group = set_foldcolumn_for_file,
			pattern = "buftype",
			callback = function()
				if vim.bo.buftype == "" then
					vim.wo.foldcolumn = "1"
				else
					vim.wo.foldcolumn = "0"
				end
			end,
		})
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	opts = {
		close_fold_kinds = { "imports" },
		-- provider_selector = function(bufnr, filetype, buftype)
		-- 	return { "treesitter", "indent" }
		-- end,
	},
	config = function(_, opts)
		-- vim.o.foldcolumn = "1" -- '0' is not bad
		-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		-- vim.o.foldlevelstart = 99
		-- vim.o.foldenable = true
		-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:|,foldclose:]]

		require("ufo").setup(opts)
		vim.keymap.set("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end)
	end,
}
