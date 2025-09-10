-- LSP Configuration setup
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the vim.uv word is found
        {path = '${3d}/luv/library', words = { 'vim%.uv' }},
      },
    },
  },
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
    dependencies = { 
      {'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
        callback = function(event)

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename a variable under the cursor
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Go To Declaration
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')


          local function client_supports_method(client, method, buffnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_group = vim.api.nvim_create_augroup('my-lsp-highlight', {clear = true})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI'}, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI'}, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'my-lsp-highlight', buffer = event2.buf}
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]int')
          end
        end,
      })
            -- Diagnostic config
          vim.diagnostic.config {
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = {severity = vim.diagnostic.severity.ERROR},
            virtual_text = {
              source = 'if_many',
              spacing = 2,
              format = function(diagnostic)
                local diagnostic_message = {
                  [vim.diagnostic.severity.ERROR] = diagnostic.message,
                  [vim.diagnostic.severity.ERROR] = diagnostic.message,
                  [vim.diagnostic.severity.ERROR] = diagnostic.message,
                  [vim.diagnostic.severity.ERROR] = diagnostic.message,
                }
                return diagnostic_message[diagnostic.severity]
              end,
            },
          }

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

        lspconfig.pyright.setup({
          capabilities = capabilities,
        })

        lspconfig.jsonls.setup({
          capabilities = capabilities,
        })
        end,
      },
  }
