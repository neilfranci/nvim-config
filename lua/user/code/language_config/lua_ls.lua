return {
  settings = {
    Lua = {
      semantic = {
        enable = false,
      },
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim", "spec" },
      },
      runtime = {
        version = "LuaJIT",
        special = {
          spec = "require",
        },
      },
      telemetry = { enable = false },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          -- [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          -- [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "Disable", -- "All" | "Literal" | "Disable"
        paramType = true,
        semicolon = "All", -- "All" | "SameLine" | "Disable"
        setType = false,
      },
    },
  },
}
