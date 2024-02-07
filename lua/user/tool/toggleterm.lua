local M = {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
}

function M.config()
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end

	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = false,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = nil, -- change the default shell
		float_opts = {
			border = "rounded",
			winblend = 5,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
		winbar = {
			enabled = true,
			name_formatter = function(term) --  term: Terminal
				return term.count
			end,
		},
	})

	-- Alwasys in insert mode
	vim.cmd([[
  augroup terminal_setup | au!
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  autocmd TermEnter * startinsert!
  augroup end
  ]])

	vim.api.nvim_create_autocmd({ "TermEnter" }, {
		pattern = { "*" },
		callback = function()
			vim.cmd("startinsert")
		end,
	})
end

return M
