return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = {"nvim-tree/nvim-web-devicons"},
  lazy = false,
  config = function()
    require("nvim-tree").setup {}
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle <CR>', {})
    vim.keymap.set('n', '<leader>e', ':NvimTreeFocus <CR>', {})
  end
}
