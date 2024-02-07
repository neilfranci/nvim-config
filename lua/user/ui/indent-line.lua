local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
}

function M.config()
	require("ibl").setup({
		indent = {
			-- char = "|",
			char = "▎",
		},
		whitespace = {
			remove_blankline_trail = true,
		},
		scope = {
			enabled = false,
			char = "▎",
			show_start = false,
			-- show_end = true,
			include = {
				node_type = {
					["*"] = { "*" },
				},
			},
		},
	})

	-- require("ibl").setup {
	--   indent = { highlight = highlight, char = "" },
	--   whitespace = {
	--       highlight = highlight,
	--       remove_blankline_trail = false,
	--   },
	--   scope = { enabled = false },
	-- }

	-- local highlight = {
	-- 	"RainbowRed",
	-- 	"RainbowYellow",
	-- 	"RainbowBlue",
	-- 	"RainbowOrange",
	-- 	"RainbowGreen",
	-- 	"RainbowViolet",
	-- 	"RainbowCyan",
	-- }
	-- local hooks = require("ibl.hooks")
	-- -- create the highlight groups in the highlight setup hook, so they are reset
	-- -- every time the colorscheme changes
	-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	-- end)
	--
	-- vim.g.rainbow_delimiters = { highlight = highlight }
	-- require("ibl").setup({ scope = { highlight = highlight } })
	--
	-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

	-- Disable indent-blankline in visual mode
	local indent_blankline_augroup = vim.api.nvim_create_augroup("indent_blankline_augroup", { clear = true })
	vim.api.nvim_create_autocmd("ModeChanged", {
		group = indent_blankline_augroup,
		pattern = "[vV\x16]*:*",
		command = "IBLEnable",
		desc = "Enable indent-blankline when exiting visual mode",
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = indent_blankline_augroup,
		pattern = "*:[vV\x16]*",
		command = "IBLDisable",
		desc = "Disable indent-blankline when enter visual mode",
	})

	local hooks = require("ibl.hooks")

	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
end

return M
