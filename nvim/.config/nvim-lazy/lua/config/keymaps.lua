-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- Open Neo-tree with Ctrl+n
vim.keymap.set("n", "<C-n>", function()
  require("neo-tree.command").execute({ toggle = true, reveal = true })
end, { desc = "Toggle Neo-tree" })
