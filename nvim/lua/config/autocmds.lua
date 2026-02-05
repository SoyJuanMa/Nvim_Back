-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Configurar diagnósticos automáticos
vim.defer_fn(function()
  require("config.diagnostics").setup()
end, 1000) -- Delay para asegurar que todo esté cargado
