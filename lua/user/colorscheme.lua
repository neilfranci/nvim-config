local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("onedark").setup({
    transparent = false,
    style = "warmer",
    -- lualine = {
    --     transparent = true, -- lualine center bar transparency
    -- },
    -- colors = {
      -- bg_d = "#1e1aaa", -- nvim tree panel?
      -- bg0 = "#282c34" -- real background
    -- },
  })
  vim.cmd.colorscheme "onedark"
end

return M
