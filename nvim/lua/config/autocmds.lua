-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Mostrar diagnósticos flotantes automáticamente cuando el cursor está sobre un error
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("FloatDiagnostics", { clear = true }),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- Configurar el tiempo de espera antes de mostrar el diagnóstico (en milisegundos)
vim.opt.updatetime = 500 -- 500ms = medio segundo
