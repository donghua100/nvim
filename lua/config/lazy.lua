local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {}
require("lazy").setup({
  { import = "plugins.ui" },
  { import = "plugins.navigation" },
  { import = "plugins.editor" },
  { import = "plugins.coding" },
  { import = "plugins.git" },
  { import = "plugins.ai" },
}, opts)
