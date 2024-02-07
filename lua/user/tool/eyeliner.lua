local M = {
  "jinh0/eyeliner.nvim",
  event = "VeryLazy",
}

function M.config()
  -- Press f for right
  require("eyeliner").setup {
    highlight_on_key = true,
    dim = true
  }
end

return M
