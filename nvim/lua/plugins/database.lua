return {
  -- El núcleo - vim-dadbod para conexiones a DBs
  {
    "tpope/vim-dadbod",
    lazy = true,
  },

  -- UI visual para manejar las bases de datos
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Configuración de vim-dadbod-ui
      vim.g.db_ui_use_nerd_fonts = 1 -- Usar Nerd Fonts para iconos
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = "left" -- Sidebar a la izquierda
      vim.g.db_ui_winwidth = 40 -- Ancho del sidebar

      -- Guardar queries en un directorio específico
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui_queries"

      -- Auto-ejecutar queries al seleccionar
      vim.g.db_ui_execute_on_save = 0 -- Cambiar a 1 si querés auto-ejecutar al guardar

      -- Tabla de iconos personalizados
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾ ",
          buffers = "▾ ",
          saved_queries = "▾ ",
          schemas = "▾ ",
          schema = "▾ פּ",
          tables = "▾ 藺",
          table = "▾ ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ ",
          saved_queries = "▸ ",
          schemas = "▸ ",
          schema = "▸ פּ",
          tables = "▸ 藺",
          table = "▸ ",
        },
        saved_query = "",
        new_query = "璘",
        tables = "離",
        buffers = "﬘",
        add_connection = "",
        connection_ok = "✓",
        connection_error = "✕",
      }
    end,
    keys = {
      { "<leader>D", "", desc = "+database" },
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Database Buffer" },
      { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Database Buffer" },
      { "<leader>Dl", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
  },

  -- Autocompletado de SQL en buffers de SQL
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    lazy = true,
    init = function()
      -- Integración con nvim-cmp (si lo tenés)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local cmp = require("cmp")
          -- Agregar la fuente de completado de dadbod
          local sources = vim.tbl_map(function(source)
            return { name = source.name }
          end, cmp.get_config().sources)
          
          table.insert(sources, { name = "vim-dadbod-completion" })
          
          cmp.setup.buffer({
            sources = sources,
          })
        end,
      })
    end,
  },
}
