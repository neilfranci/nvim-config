local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    {
      "L3MON4D3/LuaSnip", -- snippet engine
      dependencies = "rafamadriz/friendly-snippets",
    }
    -- "onsails/lspkind.nvim", -- vs-code like pictograms
	},
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  -- local lspkind = require("lspkind")

  -- loads vscode style snippets from installed plugins (e.g: friendly-snippets)
  require("luasnip.loaders.from_vscode").lazy_load()
  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local icons = require "user.icons"
  cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      expandable_indicator = true,
      -- format = lspkind.cmp_format({
      --   mode = 'symbol_text', -- show only symbol annotations
      --   maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      --   ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      --   show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      -- })
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[NVIM-LUA]",
          luasnip = "[Snippet]",
          buffer = "",
          path = "",
          emoji = "",
          codeium = "[AI]",
        })[entry.source.name]

        if entry.source.name == "emoji" then
          vim_item.kind = icons.misc.Smiley
        end

        if entry.source.name == "codeium" then
          vim_item.kind = icons.misc.Suggestion
        end

        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "codeium" },
      { name = "luasnip" }, -- For luasnip users.
      { name = "buffer" },
      { name = "path" },
    }),
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
    experimental = {
      ghost_text = true,
    },
  })
end

return M

