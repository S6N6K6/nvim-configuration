-- General init.lua

-- import the vimopts
require('vimopts')

-- Setup the lazy nvim plugin manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
      {out,                             "WarningMsg"},
      {"\nPress any key to exit ... " },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- Set the status line to look cool enough
require("utils.statusline")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Configure the treesitter
local config = require("nvim-treesitter.configs")
config.setup({
  ignore_install = {},
  ensure_installed = {
    "vimdoc",
    "c",
    "cpp",
    "lua",
    "python",
    "markdown",
    "powershell",
    "glsl",
    "asm",
    "json",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  modules = {},
  sync_install = false,
  auto_install = true,
})
