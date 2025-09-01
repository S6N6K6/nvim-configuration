-- Plugin for neovim dev
return {
  "folke/lazydev.nvim",
  ft = 'lua',
  opts = {
    library = {
      -- Load luvit types when the vim.uv word is found
      { path = "${3d}/luv/library", words = { "vim%.uv" } },
    },
  },
}
