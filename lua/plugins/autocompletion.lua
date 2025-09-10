return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'folke/lazydev.nvim',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
      opts = {},
    },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-e>'] = show,
      ['<C-space>'] = {
        function(cmp)
          cmp.show({ providers = { 'snippets' }, })
        end
      },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = false,
      },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
        show_on_blocked_trigger_characters = { "{", "(", ")", "}" },
      },
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      ghost_text = {
        enabled = true,
      },
      menu = {
        border = 'rounded',
        auto_show = true,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },
    fuzzy = { preset = 'lua' },

    signature = { enabled = true },
  },
}
