return 	{
		"neilfranci/vitesse.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"tjdevries/colorbuddy.nvim",
		},
		config = function()
			require("vitesse").setup({
				transparent_background = false,
				-- transparent_float_background = true, -- aka pum(popup menu) background
				-- colors = {
				-- },
				themes = {
					blackground = "#008EFF",
					-- activeBackground = "#008E2F",
					-- lowBackground = "#008E2F", -- Status Line Background
					lowActiveBackground = "#292929",
				},
			})
			-- vim.cmd.colorscheme("vitesse")
			local Color, colors, Group, groups, styles = require("colorbuddy").setup()

			-- Use Color.new(<name>, <#rrggbb>) to create new colors
			-- They can be accessed through colors.<name>
			--      Color.new('background',  '#008EFF')
		end,
	}

