local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile", "User FilePost" },
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
			},
		},
		-- Improve Other LSP Functionalities
		{
			"nvimdev/lspsaga.nvim",
			opts = require("user.code.lspsaga"),
		},
		{
			"folke/neodev.nvim",
			opts = {},
		},
	},
}

local keymap = vim.keymap.set

local function lsp_keymaps(bufnr)
	local buf_opts = { buffer = bufnr, silent = true }
	-- keymap("n", "gD", vim.lsp.buf.declaration, buf_opts)
	keymap("n", "gD", "<cmd>Lspsaga finder<cr>", buf_opts)
	keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", buf_opts)
	-- keymap("n", "gd", vim.lsp.buf.definition, buf_opts)
	keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", buf_opts)
	-- keymap("n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", buf_opts)
	keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>", buf_opts)
	-- keymap("n", "K", vim.lsp.buf.hover, buf_opts)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", buf_opts)
	keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", buf_opts)
end

local on_attach = function(_, bufnr)
	lsp_keymaps(bufnr)
end

function M.config()
	local lspconfig = require("lspconfig")
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
	keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
	keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
	keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
	keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens Action" })
	keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Quickfix" })
	-- keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
	keymap("n", "<leader>lr", "<cmd>lua vim.cmd.LspRestart()<cr>", { desc = "Restart LSP" })

	mason.setup({
		ui = {
			-- Whether to automatically check for new versions when opening the :Mason window.
			check_outdated_packages_on_open = false,
			border = "rounded",
			icons = {
				package_pending = " ",
				package_installed = " ",
				package_uninstalled = " ",
			},
		},
	})

	mason_lspconfig.setup({
		-- automatic_installation = true,
		ensure_installed = {
			-- Lua
			"lua_ls",
			"vimls",

			-- Web Development
			"cssls",
			"html",
			-- "tsserver",
			"volar",
			-- "tailwindcss",
			-- "emmet_language_server",

			-- C/C++
			-- "clangd",
		},
	})

	local icons = require("user.icons")
	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}

	require("lspconfig.ui.windows").default_options.border = "rounded"

	mason_lspconfig.setup_handlers({
		-- Automatically configure the LSP installed
		function(server_name)
			local opts = {
				capabilities = capabilities,
				on_attach = on_attach,
				handlers = handlers,
			}

			local require_ok, server = pcall(require, "user.code.language_config." .. server_name)
			if require_ok then
				opts = vim.tbl_deep_extend("force", server, opts)
			end
			lspconfig[server_name].setup(opts)
		end,
	})
end

return M
