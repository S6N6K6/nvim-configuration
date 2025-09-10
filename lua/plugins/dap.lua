return {
  "mfussenegger/nvim-dap",

  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },

  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function ()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F10>',
      function ()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F11>',
      function ()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F12>',
      function ()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out'
    },
    {
      '<leader>b',
      function ()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug : Toggle Breakpoint',
    },
  },
  config = function ()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'codelldb',
        'debugpy',
      },
    }

    -- Setup DAP UI
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

  end
}
