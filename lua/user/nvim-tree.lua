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
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      local ok, api = pcall(require, "nvim-tree.api")
      assert(ok, "api module is not found")
      vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))

      local mappings = {
        -- BEGIN_DEFAULT_ON_ATTACH
        ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
        ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
        ["<C-k>"] = { api.node.show_info_popup, "Info" },
        ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
        ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
        ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
        ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
        ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
        ["<Tab>"] = { api.node.open.preview, "Open Preview" },
        [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
        ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
        ["."] = { api.node.run.cmd, "Run Command" },
        ["-"] = { api.tree.change_root_to_parent, "Up" },
        ["a"] = { api.fs.create, "Create" },
        ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
        ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
        ["c"] = { api.fs.copy.node, "Copy" },
        ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
        ["]c"] = { api.node.navigate.git.next, "Next Git" },
        ["d"] = { api.fs.remove, "Delete" },
        ["D"] = { api.fs.trash, "Trash" },
        ["E"] = { api.tree.expand_all, "Expand All" },
        ["e"] = { api.fs.rename_basename, "Rename: Basename" },
        ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
        ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
        ["F"] = { api.live_filter.clear, "Clean Filter" },
        ["f"] = { api.live_filter.start, "Filter" },
        ["g?"] = { api.tree.toggle_help, "Help" },
        ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
        ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
        ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
        ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
        ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
        ["m"] = { api.marks.toggle, "Toggle Bookmark" },
        ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
        ["p"] = { api.fs.paste, "Paste" },
        ["P"] = { api.node.navigate.parent, "Parent Directory" },
        ["q"] = { api.tree.close, "Close" },
        ["r"] = { api.fs.rename, "Rename" },
        ["R"] = { api.tree.reload, "Refresh" },
        ["s"] = { api.node.run.system, "Run System" },
        ["S"] = { api.tree.search_node, "Search" },
        ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
        ["W"] = { api.tree.collapse_all, "Collapse" },
        ["x"] = { api.fs.cut, "Cut" },
        ["y"] = { api.fs.copy.filename, "Copy Name" },
        ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
        -- END_DEFAULT_ON_ATTACH

        -- Mappings migrated from view.mappings.list
        ["l"] = { api.node.open.edit, "Open" },
        ["<CR>"] = { api.node.open.edit, "Open" },
        ["o"] = { api.node.open.edit, "Open" },
        ["h"] = { api.node.navigate.parent_close, "Close Directory" },
        ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
        ["C"] = { api.tree.change_root_to_node, "CD" },
      }

      for keys, mapping in pairs(mappings) do
        vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
      end
    end
  }
}

function M.config()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local icons = require "user.icons"
  -- change color for arrows in tree to light blue
  vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
  vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

  local api = require("nvim-tree.api")
  -- Auto open when file is created
  api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
  end)

  local nvimTreeFocusOrToggle = function ()
    local nvimTree=require("nvim-tree.api")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
    if currentBufFt == "NvimTree" then
        nvimTree.tree.toggle()
    else
        nvimTree.tree.focus()
    end
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>e"] = { nvimTreeFocusOrToggle, "Explorer" },
  }

  require("nvim-tree").setup({
    disable_netrw = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    sort = {
      sorter = "case_sensitive",
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
      ignore = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 5000,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
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
          }
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
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.BoldHint,
        info = icons.diagnostics.BoldInformation,
        warning = icons.diagnostics.BoldWarning,
        error = icons.diagnostics.BoldError,
      },
    },
  })
end

return M
