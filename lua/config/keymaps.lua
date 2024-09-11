-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "v", "n" }, "y", '"+y')

-- ========================================
--   flash
-- ========================================
vim.keymap.set({ "n", "x", "o" }, "f", function()
  require("flash").jump()
end)
