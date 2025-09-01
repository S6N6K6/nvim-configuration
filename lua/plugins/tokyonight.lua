return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    styles = {
      comments = { italic = false },
    },

    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
