return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			bt_ignore = { "nofile", "terminal" },
			segments = {
				{
					sign = {
						name = { ".*" },
						text = { ".*" },
					},
					click = "v:lua.ScSa",
				},
				{ sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- Display the line number
				{
					sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
					click = "v:lua.ScSa",
				},
				{
					text = {
						function(args)
							args.fold.close = ""
							args.fold.open = ""
							args.fold.sep = "▕"
							return builtin.foldfunc(args)
						end,
					},
					click = "v:lua.ScFa",
				}, --This is a fold column replacement that does not print the fold depth digits.
				{ text = { " " } },
			},
		})
	end,
}
