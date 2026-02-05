-- Configuración de wrap automático para diagnósticos
-- Asegura que los mensajes largos se vean completos

local M = {}

-- Función para formatear mensajes con wrap inteligente
local function format_diagnostic_message(diagnostic)
  local message = diagnostic.message
  
  -- Limpiar el mensaje
  message = message:gsub("\n", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
  
  -- Si el mensaje es muy largo, cortarlo inteligentemente
  local max_length = 120 -- Máximo por línea
  if #message <= max_length then
    return message
  end
  
  -- Buscar un buen punto de corte
  local words = {}
  for word in message:gmatch("%S+") do
    table.insert(words, word)
  end
  
  local lines = {}
  local current_line = ""
  
  for _, word in ipairs(words) do
    if #current_line + #word + 1 <= max_length then
      current_line = current_line == "" and word or current_line .. " " .. word
    else
      if current_line ~= "" then
        table.insert(lines, current_line)
      end
      current_line = word
    end
  end
  
  if current_line ~= "" then
    table.insert(lines, current_line)
  end
  
  -- Retornar solo las primeras 3 líneas para virtual text
  local result = table.concat(lines, " | ", 1, 3)
  if #lines > 3 then
    result = result .. "..."
  end
  
  return result
end

-- Configuración mejorada de virtual text con wrap
function M.setup_virtual_text()
  vim.diagnostic.config({
    virtual_text = {
      spacing = 2, -- Menos espacio para más texto
      source = "if_many",
      prefix = "▶", -- Prefijo más compacto
      suffix = "",
      format = format_diagnostic_message,
    },
    
    -- Mejor configuración de float con wrap real
    float = {
      focusable = true,
      style = "minimal", 
      border = "rounded",
      source = "always",
      header = "",
      prefix = function(diagnostic, i, total)
        local level = vim.diagnostic.severity[diagnostic.severity]
        local prefix_map = {
          ERROR = "✘ ",
          WARN = "▲ ", 
          INFO = "» ",
          HINT = "⚑ ",
        }
        return prefix_map[level] or "● "
      end,
      suffix = "",
      wrap = true, -- WRAP habilitado
      max_width = math.floor(vim.o.columns * 0.6), -- 60% del ancho de pantalla
      max_height = math.floor(vim.o.lines * 0.4), -- 40% de la altura
      close_events = { 
        "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" 
      },
    },
  })
end

-- Función para mostrar float con wrap mejorado
function M.show_diagnostic_float()
  local line = vim.fn.line('.') - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  
  if #diagnostics == 0 then
    return
  end
  
  -- Configurar opciones de float con wrap garantizado
  local float_opts = {
    focusable = true,
    close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
    border = "rounded",
    source = "always", 
    prefix = function(diagnostic, i, total)
      local level = vim.diagnostic.severity[diagnostic.severity]
      local prefix_map = {
        ERROR = "✘ Error: ",
        WARN = "▲ Warning: ",
        INFO = "» Info: ", 
        HINT = "⚑ Hint: ",
      }
      return prefix_map[level] or "● "
    end,
    suffix = "",
    wrap = true,
    -- Configuración específica para wrap
    max_width = math.min(120, math.floor(vim.o.columns * 0.8)),
    max_height = 20,
    scope = "cursor",
  }
  
  vim.diagnostic.open_float(nil, float_opts)
end

return M