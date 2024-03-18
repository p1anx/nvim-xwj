-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>te", "<cmd>ToggleTerm<cr>")
vim.api.nvim_set_keymap("n", "<leader>R", ":luafile $MYVIMRC<CR>", { noremap = true, silent = true })

-- ********************************************************
-- ==>                   hop.nvim
-- ********************************************************
-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
  hop.hint_char1({ direction = nil, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "t", function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
  hop.hint_char2({ diretion = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
-- ********************************************************
-- ==>                   chatgpt.nvim
-- ********************************************************
vim.keymap.set("n", "<leader>ch", "<cmd>ChatGPT<cr>")
vim.keymap.set("n", "<leader>ci", "<cmd>ChatGPTEditWithInstructions<cr>")
-- vim.keymap.set("n", "<leader>ch", "<cmd>ChatGPT<cr>")
