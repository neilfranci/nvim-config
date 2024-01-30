local M = {
  "rmagatti/auto-session",
}

function M.config()
  local auto_session = require("auto-session")

  auto_session.setup({
    auto_save_enabled = true,
    auto_session_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
  })

  local wk = require "which-key"
  wk.register {
    ["<leader>wr"] = { "<cmd>SessionRestore<CR>", "Restore session for cwd" },
    ["<leader>ws"] = { "<cmd>SessionSave<CR>", "Save session for auto session root dir" },
  }
end

return M
