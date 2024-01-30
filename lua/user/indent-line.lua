local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
}

function M.config()
  require("ibl").setup({
    indent = {
      char = "|",
    },
    scope = {
      char = "│",
      show_end = false,
      highlight = "IndentBlanklineContextChar",
      include = {
        node_type = {
          ["*"] = { "*" },
        },
      },
      enabled = true,
    },
  })

  local hooks = require "ibl.hooks"

  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_tab_indent_level
  )
end

return M
