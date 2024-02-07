local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			dependencies = "rafamadriz/friendly-snippets",
		},
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
}

M.has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	-- loads vscode style snippets from installed plugins (e.g: friendly-snippets)
	require("luasnip.loaders.from_vscode").lazy_load()
	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local icons = require("user.icons")
	local kind_icons = {
		Text = "",
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "󰇽",
		Variable = "󰂡",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰅲",
		Codeium = icons.misc.Suggestion,
	}

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			-- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			-- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif M.has_words_before() then
					cmp.complete()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
		formatting = {
			fields = { "abbr", "kind", "menu" },
			expandable_indicator = false,
			-- format = require('lspkind').cmp_format {
			--   mode = 'symbol',
			--   maxwidth = 40,
			--   ellipsis_char = '...',
			--   symbol_map = {
			--     TypeParameter = 'T',
			--     Codeium = '󰇈',
			--   },
			-- },

			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = kind_icons[vim_item.kind]
				-- Source
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[NVIM-LUA]",
					luasnip = "[Snippet]",
					buffer = "",
					-- path = "[PATH]",
					codeium = "[AI]",
				})[entry.source.name]

				return vim_item
			end,
		},
		sources = cmp.config.sources({
			{ name = "codeium" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" }, -- For luasnip users.
			{ name = "buffer" },
			{ name = "path" },
		}),
		-- confirm_opts = {
		--   behavior = cmp.ConfirmBehavior.Replace,
		--   select = false,
		-- },
		window = {
			completion = {
				border = "rounded",
				winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
				col_offset = -3,
				side_padding = 1,
				scrollbar = false,
			},
			documentation = {
				border = "rounded",
				scrollbar = false,
				winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
			},
		},
		matching = {
			disallow_fuzzy_matching = true,
			disallow_fullfuzzy_matching = true,
			disallow_partial_fuzzy_matching = true,
			disallow_partial_matching = false,
			disallow_prefix_unmatching = true,
		},
		performance = {
			debounce = 60,
			throttle = 30,
			fetching_timeout = 500,
			confirm_resolve_timeout = 500,
			async_budget = 1,
			max_view_entries = 200,
		},
		experimental = {
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},
	})
end

return M
