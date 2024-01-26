return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 998,
    opts = {},
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
