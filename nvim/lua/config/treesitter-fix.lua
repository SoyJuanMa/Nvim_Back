-- Configuración para deshabilitar spam de Treesitter highlights

-- Deshabilitar notificaciones molestas de Treesitter
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Deshabilitar logging de Treesitter que causa el spam
    if vim.treesitter then
      -- Silenciar warnings de highlight links
      vim.treesitter.language = vim.treesitter.language or {}
      
      -- Override de la función que causa spam
      local original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == "string" then
          -- Filtrar TODOS los mensajes de Treesitter highlights
          if string.match(msg, "@%w*%.?%w* links to @%w+") then
            return
          end
          if string.match(msg, "priority:") and string.match(msg, "language:") then
            return
          end
          if string.match(msg, "Treesitter") then
            return
          end
        end
        original_notify(msg, level, opts)
      end
    end
  end,
})

-- Configuración adicional para Treesitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Deshabilitar spell checking en markdown que causa problemas
    vim.opt_local.spell = false
  end,
})

return {}