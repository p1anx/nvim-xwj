-- "bootstrap lazy.nvim, LazyVim and your plugins
if vim.fn.exists("g:os") == 0 then
  local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
  if is_windows then
    vim.g.os = "Windows"
  else
    local uname_output = vim.fn.system("uname")
    vim.g.os = string.gsub(uname_output, "\n", "")
  end
end

require("config.lazy")

if vim.g.os == "Windows" then
  vim.keymap.set("v", "<c-x>", '"+x')
  vim.keymap.set("v", "<c-c>", '"+y')
elseif vim.g.os == "Linux" then
  vim.keymap.set("v", "<c-x>", '"+x')
  vim.keymap.set("v", "<c-c>", '"+y')
end

vim.cmd("colorscheme onedark")
