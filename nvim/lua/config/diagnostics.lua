-- Configuración SIMPLE de diagnósticos que funciona

local M = {}

-- Configuración básica de diagnósticos CON ICONOS COLORIDOS  
vim.diagnostic.config({
  virtual_text = false, -- Sin texto virtual
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚", -- Icono de X rojo para errores
      [vim.diagnostic.severity.WARN] = "󰀪", -- Icono de triángulo amarillo para warnings  
      [vim.diagnostic.severity.INFO] = "󰋽", -- Icono de info azul
      [vim.diagnostic.severity.HINT] = "󰌶", -- Icono de bombilla para hints
    },
  },
  underline = true, -- Subrayar errores
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    border = "rounded",
    source = "always",
    header = "",
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "󰅚 Error: ",
        [vim.diagnostic.severity.WARN] = "󰀪 Warning: ",
        [vim.diagnostic.severity.INFO] = "󰋽 Info: ",
        [vim.diagnostic.severity.HINT] = "󰌶 Hint: ",
      }
      return icons[diagnostic.severity] or "● "
    end,
    suffix = "",
    wrap = true,
    max_width = 80,
    max_height = 20,
  },
})

-- Función SIMPLE para mostrar diagnósticos
local function show_diagnostics()
  local line = vim.fn.line('.') - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  
  if #diagnostics > 0 then
    vim.diagnostic.open_float(nil, {
      scope = "line",
      focusable = true,
      border = "rounded",
      wrap = true,
      max_width = 80,
      close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre"},
    })
  end
end

-- Configuración SIMPLE de colores con iconos bien visibles
local function setup_colors()
  -- Colores para líneas con errores (MÁS VISIBLES)
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { 
    bg = "#4a1a1a", -- Fondo rojo más oscuro
    fg = "#ff6b6b", -- Texto rojo brillante
    undercurl = true,
    sp = "#ff4757", -- Subrayado rojo intenso
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { 
    bg = "#4a3a00", -- Fondo amarillo oscuro
    fg = "#feca57", -- Texto amarillo brillante
    undercurl = true,
    sp = "#ff9f43", -- Subrayado naranja
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { 
    bg = "#1a2a4a", -- Fondo azul oscuro
    fg = "#48cae4", -- Texto azul claro
    undercurl = true,
    sp = "#0077be", -- Subrayado azul
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { 
    bg = "#0a3325", -- Fondo verde oscuro
    fg = "#00ff88", -- Texto verde neón 
    undercurl = true,
    sp = "#00ff88", -- Subrayado verde intenso
  })
  
  -- Iconos en la columna lateral CON COLORES INTENSOS
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { 
    fg = "#ff4757", -- Rojo intenso
    bg = "NONE",
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { 
    fg = "#ff9f43", -- Naranja brillante
    bg = "NONE",
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { 
    fg = "#48cae4", -- Azul claro
    bg = "NONE",
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { 
    fg = "#00ff88", -- Verde neón
    bg = "NONE",
  })
  
  -- Colores para texto en los floats
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { 
    fg = "#ff6b6b", 
    bg = "#1e222a" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { 
    fg = "#feca57", 
    bg = "#1e222a" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { 
    fg = "#48cae4", 
    bg = "#1e222a" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { 
    fg = "#00ff88", -- Verde neón
    bg = "#1e222a",
  })
end

-- Setup SIMPLE
function M.setup()
  setup_colors()
  
  -- Mapear K DIRECTAMENTE
  vim.keymap.set("n", "K", function()
    local line = vim.fn.line('.') - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = line })
    
    if #diagnostics > 0 then
      show_diagnostics()
    else
      vim.lsp.buf.hover()
    end
  end, { desc = "Show diagnostics or LSP hover", noremap = true, silent = true })
  
  -- Mostrar diagnósticos automáticamente al parar el cursor
  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("DiagnosticsShow", { clear = true }),
    callback = function()
      local line = vim.fn.line('.') - 1
      local diagnostics = vim.diagnostic.get(0, { lnum = line })
      if #diagnostics > 0 then
        vim.defer_fn(function()
          show_diagnostics()
        end, 100)
      end
    end,
  })
  
  -- Configurar timing
  vim.opt.updatetime = 1000 -- 1 segundo
end

return M