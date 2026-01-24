-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- Open Neo-tree with Ctrl+n
vim.keymap.set("n", "<C-n>", function()
  require("neo-tree.command").execute({ toggle = true, reveal = true })
end, { desc = "Toggle Neo-tree" })

vim.keymap.set("i", "<C-n>", function()
  require("cmp").complete()
end, { desc = "Trigger completion" })
