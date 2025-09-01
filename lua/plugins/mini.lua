return {
  "echasnovski/mini.nvim",
  config = function()
    -- Around / Inside textobjects plugin
    require('mini.ai').setup{ n_lines = 500 }

    -- Text edit operators
    require('mini.operators').setup()

    -- Surround actions
    require('mini.surround').setup()

    -- Move any selection in any direction
    require('mini.move').setup()

    -- Split and join arguments
    require('mini.splitjoin').setup()

    -- Go forward/backward with square brackets
    require('mini.bracketed').setup()

  end
}
