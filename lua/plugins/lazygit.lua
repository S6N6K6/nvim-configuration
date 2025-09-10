return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  
  -- Optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  keys = {
    { '<leader>lg', '<cmd>LazyGit<CR>', desc = "LazyGit" }
  },
}
