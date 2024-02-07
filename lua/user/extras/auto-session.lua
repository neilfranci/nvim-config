local M = {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
	},
}

function M.config()
	local auto_session = require("auto-session")
	---@diagnostic disable:missing-fields
	auto_session.setup({
		auto_save_enabled = true,
		auto_session_enabled = true,
		auto_restore_enabled = false,
		auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
	})
end

return M
