-- "bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
if vim.fn.has("win32") or vim.fn.has("win64") then
  -- print("hello windows")
  -- vim.api.nvim_out_write("Hello, Neovim!\n")
  if vim.fn.has("clipboard") then
    vim.keymap.set("v", "<c-x>", '"+x')
    vim.keymap.set("v", "<c-c>", '"+y')
  end
  -- vim.keymaps.set('v', '<c-x>', "\"+x")
elseif vim.fn.has("linux") then
  print("hello linux")
  vim.api.nvim_out_write("hello, neovim!\n")
  if vim.fn.has("clipboard") then
    vim.keymap.set("v", "<c-x>", '"+x')
    vim.keymap.set("v", "<c-c>", '"+y')
  end
end
vim.cmd("colorscheme onedark")
