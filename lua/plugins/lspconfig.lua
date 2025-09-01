-- LSP Configuration setup
return {
  { 
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end, 
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cmake",
          "clangd",
          "lua_ls",
          "jsonls",
          "pyright",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      -- Set cmake behavior
      lspconfig.cmake.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = {"vim"}, -- Recognize 'vim' as a global variable
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("",true),
                "${3rd}/love2d/library",
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

    end
  },
}
