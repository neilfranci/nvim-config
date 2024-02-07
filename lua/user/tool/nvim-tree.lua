-- In order for NvimTree trash to works
-- when Shift+D over a file in nvim-tree
-- install trash-cli first
-- https://github.com/sindresorhus/trash-cli

local M = {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	opts = {
		-- Auto focus already opened files
		on_attach = function(bufnr)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = false, nowait = true }
			end
			local ok, api = pcall(require, "nvim-tree.api")
			assert(ok, "api module is not found")
			vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))
			-- { key = "t", action = "swap_then_open_tab", action_cb = swap_then_open_tab },
		end,
	},
}

function M.config()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	local api = require("nvim-tree.api")

	local icons = require("user.icons")
	-- change color for arrows in tree to light blue
	vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
	vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

	local nvimTreeFocusOrToggle = function()
		local currentBuf = vim.api.nvim_get_current_buf()
		local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
		if currentBufFt == "NvimTree" then
			api.tree.toggle()
		else
			api.tree.focus()
			api.tree.reload()
		end
	end

	local wk = require("which-key")
	wk.register({
		["<leader>e"] = { nvimTreeFocusOrToggle, "Explorer" },
	})
	-- Auto open when file is created
	api.events.subscribe(api.events.Event.FileCreated, function(file)
		vim.cmd("edit " .. file.fname)
	end)

	require("nvim-tree").setup({
		disable_netrw = true,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		sort = {
			sorter = "name",
		},
		view = {
			relativenumber = true,
			cursorline = true,
			-- adaptive_size = false,
			side = "left",
			width = 30,
			-- preserve_window_proportions = true
		},
		git = {
			enable = true,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = true,
				-- quit_on_open = true,
			},
		},
		renderer = {
			highlight_git = true,
			root_folder_label = false,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				glyphs = {
					default = "󰈚",
					symlink = "",
					folder = {
						default = "",
						empty = icons.ui.EmptyFolder,
						empty_open = icons.ui.EmptyFolderOpen,
						open = icons.ui.FolderOpen,
						symlink = "",
						symlink_open = "",
						arrow_closed = icons.ui.ChevronRight,
						arrow_open = icons.ui.ChevronDown,
					},
					git = {
						unstaged = icons.git.FileUnstaged,
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = icons.git.FileUntracked,
						deleted = "",
						ignored = icons.git.FileIgnored,
					},
				},
			},
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
			symlink_destination = true,
		},
		filters = {
			custom = { "^.git$" },
			-- dotfiles = true,
		},
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = false, -- Turn into false from true by default
		},
		diagnostics = {
			enable = false,
			-- show_on_dirs = false,
			-- show_on_open_dirs = true,
			-- debounce_delay = 50,
			-- severity = {
			-- 	min = vim.diagnostic.severity.HINT,
			-- 	max = vim.diagnostic.severity.ERROR,
			-- },
			-- icons = {
			-- 	hint = icons.diagnostics.BoldHint,
			-- 	info = icons.diagnostics.BoldInformation,
			-- 	warning = icons.diagnostics.BoldWarning,
			-- 	error = icons.diagnostics.BoldError,
			-- },
		},
	})
end

return M
