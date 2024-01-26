local options = {
  defaults = {
    layout_strategy = "horizontal",
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  }
}

return options
