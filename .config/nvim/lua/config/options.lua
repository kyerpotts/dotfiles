require("config.remote_clipboard").setup()
if vim.env.WSL_DISTRO_NAME ~= nil then
  vim.opt.clipboard = ""
end

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true
