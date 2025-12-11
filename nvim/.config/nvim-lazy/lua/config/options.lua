-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set default shell to PowerShell on Windows
if vim.loop.os_uname().version:match("Windows") then
  vim.notify("Welcome windows user!")
  vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
else
  vim.notify("Welcome linux user!")
end
