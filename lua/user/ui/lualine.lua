local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPre",
}

function M.config()
	local lualine = require("lualine")
	local lazy_status = require("lazy.status") -- to configure lazy pending updates count

	-- configure lualine with modified theme
	lualine.setup({
		options = {
			theme = "auto",
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			-- component_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "starter" },
			},
			ignore_focus = {
				"NvimTree",
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				"diff",
			},
			lualine_c = { "diagnostics" },
			lualine_x = {
				{
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = "#ff9e64" },
				},
				{ "filename" },
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-tree", "lazy" },
		-- inactive_sections = {
		--   lualine_a = {},
		--   lualine_b = {},
		--   lualine_c = {},
		--   lualine_x = {'location'},
		--   lualine_y = {},
		--   lualine_z = {}
		-- },
	})
end

return M
