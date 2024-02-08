return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	cmd = "Gitsigns",
	config = function()
		local icons = require("user.icons")

		local wk = require("which-key")
		wk.register({
			g = {
				j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
				d = {
					"<cmd>Gitsigns diffthis HEAD<cr>",
					"Git Diff",
				},
			},
		}, { mode = "n", prefix = "<leader>" })

		require("gitsigns").setup({
			signs = {
				add = { text = icons.ui.BoldLineMiddle },
				change = { text = icons.ui.BoldLineMiddle },
				delete = { text = icons.ui.Triangle },
				topdelete = { text = icons.ui.Triangle },
				changedelete = { text = "~" },
				untracked = { text = icons.ui.BoldLineDashedMiddle },
			},
			attach_to_untracked = true,
			current_line_blame = true,
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})
	end,
}
