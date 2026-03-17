return {
  "midoBB/nvim-quicktype",
  cmd = { "QuickType", "QuickTypeBuffer", "QuickTypeClipboard", "QuickTypeSelection" },
  ft = { 
    "typescript", "typescriptreact", "javascript", "javascriptreact",
    "json", "bigfile"
  },
  
  config = function()
    require("nvim-quicktype").setup({
      global = {
        cmd = vim.fn.expand("~/.npm-global/bin/quicktype"),
        src_lang = "json",
        no_combine_classes = false,
        all_properties_optional = false,
        alphabetize_properties = true,
        telemetry = "disable",
        output_file = nil,
        debug_dir = nil,
        clipboard_source_register = nil,
      },
      
      filetypes = {
        -- Solo TypeScript/React - tu stack
        typescript = {
          lang = "typescript",
          additional_options = {
            ["just-types"] = true, -- Solo interfaces/types, no clases
            ["prefer-unions"] = true, -- Union types
            ["nice-property-names"] = true, -- Nombres legibles
            ["acronym-style"] = "camel", -- camelCase
          },
        },
        
        typescriptreact = {
          lang = "typescript",
          additional_options = {
            ["just-types"] = true,
            ["prefer-unions"] = true,
            ["nice-property-names"] = true,
            ["acronym-style"] = "camel",
          },
        },
        
        javascript = {
          lang = "typescript", -- Generar TS types para JS también
          additional_options = {
            ["just-types"] = true,
            ["prefer-unions"] = true,
            ["nice-property-names"] = true,
            ["acronym-style"] = "camel",
          },
        },
        
        javascriptreact = {
          lang = "typescript", -- Generar TS types para JSX también
          additional_options = {
            ["just-types"] = true,
            ["prefer-unions"] = true,
            ["nice-property-names"] = true,
            ["acronym-style"] = "camel",
          },
        },
        
        -- Para archivos grandes (bigfile)
        bigfile = {
          lang = "typescript",
          additional_options = {
            ["just-types"] = true,
            ["prefer-unions"] = true,
            ["nice-property-names"] = true,
            ["acronym-style"] = "camel",
          },
        },
      },
    })
    
    -- Función clipboard
    local function quicktype_from_clipboard()
      local clipboard = vim.fn.getreg("+")
      if clipboard == "" then
        clipboard = vim.fn.getreg("*")
      end
      
      if clipboard == "" then
        return
      end
      
      local success, _ = pcall(vim.json.decode, clipboard)
      if not success then
        return
      end
      
      vim.cmd("QuickType")
    end
    
    -- Función buffer
    local function quicktype_from_buffer()
      vim.cmd("QuickType")
    end
    
    -- Función selección (usa interfaz interactiva original SIN borrar automáticamente)
    local function quicktype_from_selection(opts)
      local start_line = opts.line1
      local end_line = opts.line2
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      
      if #lines == 0 then
        return
      end
      
      local json_text = table.concat(lines, "\n")
      local success, _ = pcall(vim.json.decode, json_text)
      if not success then
        return
      end
      
      -- Crear un marcador único para encontrar el texto después
      local marker = "/* QUICKTYPE_TEMP_MARKER_" .. os.time() .. " */"
      
      -- Insertar marcador antes del JSON
      vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, {marker})
      
      -- Guardar info de la selección con el marcador
      _G.quicktype_last_selection = {
        buf = vim.api.nvim_get_current_buf(),
        marker = marker,
        text = json_text,
        line_count = end_line - start_line + 1
      }
      
      -- Copiar la selección al clipboard temporalmente
      local original_clipboard = vim.fn.getreg("+")
      vim.fn.setreg("+", json_text)
      
      -- Ejecutar la interfaz interactiva original
      vim.cmd("QuickType")
      
      -- Solo restaurar clipboard, NO borrar automáticamente
      vim.defer_fn(function()
        vim.fn.setreg("+", original_clipboard)
      end, 1000)
    end
    
    -- Comando para borrar la última selección JSON manualmente
    local function delete_last_selection()
      if _G.quicktype_last_selection then
        local selection = _G.quicktype_last_selection
        local buf = selection.buf
        local marker = selection.marker
        local original_text = selection.text
        local line_count = selection.line_count
        
        if vim.api.nvim_buf_is_valid(buf) then
          -- Cambiar al buffer correcto si no estamos en él
          if vim.api.nvim_get_current_buf() ~= buf then
            vim.api.nvim_set_current_buf(buf)
          end
          
          -- Buscar el marcador en todo el buffer
          local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          local marker_line = nil
          
          for i, line in ipairs(all_lines) do
            if line == marker then
              marker_line = i
              break
            end
          end
          
          if marker_line then
            -- Verificar que el JSON sigue ahí después del marcador
            local json_lines = vim.api.nvim_buf_get_lines(buf, marker_line, marker_line + line_count, false)
            local current_text = table.concat(json_lines, "\n")
            
            if current_text == original_text then
              -- Borrar el marcador Y el JSON
              vim.api.nvim_buf_set_lines(buf, marker_line - 1, marker_line + line_count, false, {})
            else
              -- Solo borrar el marcador si el JSON cambió
              vim.api.nvim_buf_set_lines(buf, marker_line - 1, marker_line, false, {})
            end
          end
        end
        
        _G.quicktype_last_selection = nil
      end
    end
    
    -- Función para reemplazar selección con tipos generados inline (interfaz interactiva)
    local function quicktype_replace_selection(opts)
      local start_line = opts.line1
      local end_line = opts.line2
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      
      if #lines == 0 then
        return
      end
      
      local json_text = table.concat(lines, "\n")
      local success, _ = pcall(vim.json.decode, json_text)
      if not success then
        return
      end
      
      local original_clipboard = vim.fn.getreg("+")
      vim.fn.setreg("+", json_text)
      
      vim.cmd("QuickType")
      
      vim.defer_fn(function()
        vim.fn.setreg("+", original_clipboard)
      end, 2000)
    end
    
    -- Comandos
    vim.api.nvim_create_user_command("QuickTypeClipboard", quicktype_from_clipboard, {
      desc = "QuickType desde clipboard"
    })
    
    vim.api.nvim_create_user_command("QuickTypeBuffer", quicktype_from_buffer, {
      desc = "QuickType desde buffer"
    })
    
    vim.api.nvim_create_user_command("QuickTypeSelection", function(opts)
      quicktype_from_selection(opts)
    end, {
      desc = "QuickType desde selección",
      range = true,
    })
    
    vim.api.nvim_create_user_command("QuickTypeDeleteLast", delete_last_selection, {
      desc = "Borrar última selección JSON procesada"
    })
    
    vim.api.nvim_create_user_command("QuickTypeDebugLast", function()
      if _G.quicktype_last_selection then
        local s = _G.quicktype_last_selection
        vim.notify(
          string.format("Buffer: %d | Líneas: %d-%d | Texto: %s...", 
            s.buf, s.start_line, s.end_line, string.sub(s.text, 1, 30)),
          vim.log.levels.INFO,
          { title = "QuickType Debug" }
        )
      else
        vim.notify("No hay selección guardada", vim.log.levels.WARN, { title = "QuickType Debug" })
      end
    end, {
      desc = "Debug: mostrar última selección guardada"
    })
    
    vim.api.nvim_create_user_command("QuickTypeReplace", quicktype_replace_selection, {
      desc = "QuickType reemplazar selección inline",
      range = true,
    })
    
    vim.api.nvim_create_user_command("QuickTypeBuffer", quicktype_from_buffer, {
      desc = "QuickType desde buffer"
    })
    
    vim.api.nvim_create_user_command("QuickTypeSelection", quicktype_from_selection, {
      desc = "QuickType desde selección (borra original)",
      range = true,
    })
    
    vim.api.nvim_create_user_command("QuickTypeReplace", quicktype_replace_selection, {
      desc = "QuickType reemplazar selección inline",
      range = true,
    })
    
    -- Solo verificar instalación silenciosamente
    vim.defer_fn(function()
      local handle = io.popen(vim.fn.expand("~/.npm-global/bin/quicktype") .. " --version 2>/dev/null")
      if handle then
        handle:read("*a")
        handle:close()
      end
    end, 2000)
  end,
  
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
}