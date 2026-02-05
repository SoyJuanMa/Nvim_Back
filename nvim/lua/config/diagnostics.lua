-- Configuración de diagnósticos inline con wrap automático
-- Los errores aparecen directamente en el editor como gitsigns

local M = {}

-- Función para formatear mensajes con wrap inteligente
local function format_diagnostic_message(diagnostic)
  local message = diagnostic.message
  
  -- Limpiar el mensaje
  message = message:gsub("\n", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
  
  -- Si el mensaje es muy largo, cortarlo inteligentemente
  local max_length = 100 -- Máximo por línea virtual
  if #message <= max_length then
    return " " .. message
  end
  
  -- Cortar inteligentemente
  local truncated = message:sub(1, max_length - 3) .. "..."
  return " " .. truncated
end

-- Configuración de diagnósticos de Neovim
vim.diagnostic.config({
  -- Deshabilitar texto virtual inline
  virtual_text = false, -- SIN texto a la derecha
  
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  
  underline = true, -- Subrayar errores (línea roja)
  update_in_insert = false, -- No actualizar en modo insert
  severity_sort = true, -- Ordenar por severidad
  
  -- Configuración de float mejorada con wrap REAL
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = function(diagnostic, i, total)
      local level = vim.diagnostic.severity[diagnostic.severity]
      local icons = {
        [vim.diagnostic.severity.ERROR] = "✘ Error: ",
        [vim.diagnostic.severity.WARN] = "▲ Warning: ",
        [vim.diagnostic.severity.INFO] = "» Info: ",
        [vim.diagnostic.severity.HINT] = "⚑ Hint: ",
      }
      return icons[diagnostic.severity] or "● "
    end,
    suffix = "",
    wrap = true, -- WRAP habilitado
    -- Configuración dinámica basada en tamaño de pantalla
    max_width = function() 
      return math.min(120, math.floor(vim.o.columns * 0.8)) 
    end,
    max_height = function() 
      return math.min(20, math.floor(vim.o.lines * 0.3)) 
    end,
    close_events = { 
      "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" 
    },
  },
})

-- Función para mostrar diagnóstico flotante con wrap garantizado
local function show_line_diagnostics()
  local line = vim.fn.line('.') - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  
  if #diagnostics == 0 then
    return
  end

  local opts = {
    focusable = true,
    close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
    border = "rounded",
    source = "always",
    prefix = function(diagnostic, i, total)
      local level = vim.diagnostic.severity[diagnostic.severity]
      local icons = {
        [vim.diagnostic.severity.ERROR] = "✘ Error: ",
        [vim.diagnostic.severity.WARN] = "▲ Warning: ",
        [vim.diagnostic.severity.INFO] = "» Info: ",
        [vim.diagnostic.severity.HINT] = "⚑ Hint: ",
      }
      return icons[diagnostic.severity] or "● "
    end,
    suffix = "",
    scope = "cursor", -- Solo diagnósticos en la línea actual
    wrap = true, -- WRAP habilitado
    -- Configuración específica para asegurar wrap
    max_width = math.min(120, math.floor(vim.o.columns * 0.8)),
    max_height = 20,
  }
  
  vim.diagnostic.open_float(nil, opts)
end

-- Función para configurar autocomandos
local function setup_autocmds()
  local group = vim.api.nvim_create_augroup("InlineDiagnostics", { clear = true })
  
  -- Mostrar diagnóstico flotante automáticamente al mantener el cursor
  vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function()
      -- Solo mostrar si hay diagnósticos en la línea actual
      local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
      if #diagnostics > 0 then
        show_line_diagnostics()
      end
    end,
  })
  
  -- Configurar el tiempo de CursorHold (en milisegundos)
  vim.opt.updatetime = 1000 -- Mostrar después de 1 segundo sin mover el cursor
  
  -- Mejorar el comportamiento de K
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(ev)
      local opts = { buffer = ev.buf }
      -- Mapear K solo para diagnósticos, sin mensajes molestos
      vim.keymap.set("n", "K", function()
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
        if #diagnostics > 0 then
          show_line_diagnostics()
        else
          -- Intentar hover silenciosamente
          local params = vim.lsp.util.make_position_params()
          vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
            -- Solo mostrar hover si realmente hay contenido útil
            if result and result.contents then
              local contents = result.contents
              local has_content = false
              
              -- Revisar si hay contenido real
              if type(contents) == "string" and contents ~= "" then
                has_content = true
              elseif type(contents) == "table" then
                if contents.value and contents.value ~= "" then
                  has_content = true
                elseif type(contents) == "table" and #contents > 0 then
                  for _, content in ipairs(contents) do
                    if type(content) == "string" and content ~= "" then
                      has_content = true
                      break
                    elseif type(content) == "table" and content.value and content.value ~= "" then
                      has_content = true
                      break
                    end
                  end
                end
              end
              
              -- Solo mostrar si hay contenido real
              if has_content then
                vim.lsp.buf.hover()
              end
              -- Si no hay contenido, no hacer nada (sin mensaje molesto)
            end
          end)
        end
      end, opts)
    end,
  })
  
  -- Colorear números de línea con errores
  vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
    group = group,
    callback = function()
      local diagnostics = vim.diagnostic.get(0)
      
      -- Limpiar highlights anteriores
      vim.fn.clearmatches()
      
      -- Aplicar colores a líneas con diagnósticos
      for _, diagnostic in ipairs(diagnostics) do
        local line_nr = diagnostic.lnum + 1
        local severity = diagnostic.severity
        
        if severity == vim.diagnostic.severity.ERROR then
          vim.fn.matchaddpos("DiagnosticLineNrError", { line_nr })
        elseif severity == vim.diagnostic.severity.WARN then
          vim.fn.matchaddpos("DiagnosticLineNrWarn", { line_nr })
        elseif severity == vim.diagnostic.severity.INFO then
          vim.fn.matchaddpos("DiagnosticLineNrInfo", { line_nr })
        elseif severity == vim.diagnostic.severity.HINT then
          vim.fn.matchaddpos("DiagnosticLineNrHint", { line_nr })
        end
      end
    end,
  })
  
  -- Agregar comando para mostrar todos los diagnósticos del buffer
  vim.api.nvim_create_user_command("DiagnosticsList", function()
    vim.diagnostic.setloclist()
  end, { desc = "Mostrar lista de diagnósticos del buffer" })
end

-- Función para configurar colores de diagnósticos (línea completa coloreada)
local function setup_colors()
  -- Colores para toda la línea con fondo
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { 
    bg = "#3c1518", -- Fondo rojo oscuro para errores
    fg = "#f38ba8", -- Texto rojo claro
    undercurl = true,
    sp = "#f38ba8", -- Subrayado rojo
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { 
    bg = "#3c2f00", -- Fondo amarillo oscuro para warnings
    fg = "#f9e2af", -- Texto amarillo claro
    undercurl = true,
    sp = "#f9e2af", -- Subrayado amarillo
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { 
    bg = "#1e2a3c", -- Fondo azul oscuro para info
    fg = "#89b4fa", -- Texto azul claro
    undercurl = true,
    sp = "#89b4fa", -- Subrayado azul
  })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { 
    bg = "#1e3c32", -- Fondo verde oscuro para hints
    fg = "#94e2d5", -- Texto verde claro
    undercurl = true,
    sp = "#94e2d5", -- Subrayado verde
  })
  
  -- Signos en la columna lateral más visibles
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { 
    fg = "#f38ba8", 
    bg = "NONE" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { 
    fg = "#f9e2af", 
    bg = "NONE" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { 
    fg = "#89b4fa", 
    bg = "NONE" 
  })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { 
    fg = "#94e2d5", 
    bg = "NONE" 
  })
  
  -- Números de línea coloreados para líneas con errores
  vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { 
    fg = "#f38ba8", 
    bg = "#3c1518",
    bold = true
  })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { 
    fg = "#f9e2af", 
    bg = "#3c2f00",
    bold = true
  })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { 
    fg = "#89b4fa", 
    bg = "#1e2a3c",
    bold = true
  })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { 
    fg = "#94e2d5", 
    bg = "#1e3c32",
    bold = true
  })
end

-- Función principal de setup
function M.setup()
  setup_colors()
  setup_autocmds()
  
  -- Asegurar que trouble esté cerrado si existe
  pcall(function()
    local trouble = require("trouble")
    if trouble and trouble.close then
      trouble.close()
    end
  end)
  

end

-- Función para toggle de diagnósticos (subrayado y signos)
function M.toggle_diagnostics()
  local config = vim.diagnostic.config()
  local enabled = config.underline or config.signs
  
  vim.diagnostic.config({
    underline = not enabled,
    signs = not enabled
  })
  
  local status = enabled and "deshabilitados" or "habilitados"
  print("Diagnósticos " .. status)
end

-- Función para mostrar diagnósticos manualmente
function M.show_diagnostics()
  show_line_diagnostics()
end

-- Función para ver todos los diagnósticos en quickfix
function M.show_all_diagnostics()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end

return M