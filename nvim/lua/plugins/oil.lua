-- Oil.nvim: Edit your filesystem like a buffer
-- URL: https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",

  lazy = false,

  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open Oil (parent dir)" },
  },

  opts = {
    default_file_explorer = true,
    restore_win_options = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    use_default_keymaps = false,

    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
      ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["q"] = "actions.close",
    },

    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
        return name == ".." or name == ".git"
      end,
      natural_order = true,
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
      
      -- Iconos personalizados con colores específicos
      symbols = {
        files = {
          -- === ARCHIVOS ESPECÍFICOS CON COLORES ===
          -- JavaScript (amarillo)
          ["package.json"] = "󰎙",
          ["jest.config.js"] = "󰙨",
          ["webpack.config.js"] = "󰜷",
          ["vite.config.js"] = "󰚩",
          ["rollup.config.js"] = "󰊢",
          ["babel.config.js"] = "󰨞",
          ["eslint.config.js"] = "󰱺",
          ["prettier.config.js"] = "󰉿",
          
          -- TypeScript (azul)
          ["tsconfig.json"] = "󰛦",
          ["jest.config.ts"] = "󰙨",
          ["next.config.ts"] = "󰚩",
          
          -- Docker (azul océano)
          ["Dockerfile"] = "󰡨",
          ["docker-compose.yml"] = "󰡨",
          ["docker-compose.yaml"] = "󰡨",
          [".dockerignore"] = "󰡨",
          
          -- Base de datos
          ["prisma.schema"] = "󰔶",
          ["schema.prisma"] = "󰔶",
          ["drizzle.config.ts"] = "󰆼",
          
          -- Bun (rosa/naranja)
          ["bun.lockb"] = "󰂫",
          ["bunfig.toml"] = "󰂫",
          
          -- React específicos
          ["next.config.js"] = "󰚩",
          ["nuxt.config.js"] = "󱄆", 
          ["astro.config.js"] = "󰑣",
          ["svelte.config.js"] = "󰜈",
          ["vue.config.js"] = "󰡄",
          ["tailwind.config.js"] = "󱏿",
          ["remix.config.js"] = "󰿨",
          
          -- Testing específicos
          ["vitest.config.js"] = "󰙨",
          ["vitest.config.ts"] = "󰙨",
          ["playwright.config.js"] = "󰙨",
          ["playwright.config.ts"] = "󰙨",
          ["cypress.config.js"] = "󰙨",
          ["cypress.config.ts"] = "󰙨",
          
          -- Mongo y APIs
          ["mongodb.js"] = "󰆧",
          ["mongoose.js"] = "󰆧", 
          ["apollo.config.js"] = "󰘬",
          ["graphql.config.js"] = "󰘬",
          
          -- Otros configs importantes
          [".env"] = "󰙪",
          [".env.local"] = "󰙪",
          [".env.example"] = "󰙪",
          ["nodemon.json"] = "󰚩",
          ["turbo.json"] = "󰚩",
          ["lerna.json"] = "󰚩",
          ["rush.json"] = "󰚩",
          
          -- === EXTENSIONES POR COLORES ===
          -- JavaScript (amarillo) 
          [".js"] = "󰌞",
          [".mjs"] = "󰌞",
          [".cjs"] = "󰌞",
          [".jsx"] = "",
          
          -- TypeScript (azul)
          [".ts"] = "󰛦", 
          [".tsx"] = "",
          [".d.ts"] = "󰛦",
          
          -- Testing (rojo/rosa)
          [".test.js"] = "󰙨",
          [".test.ts"] = "󰙨",
          [".test.jsx"] = "󰙨",
          [".test.tsx"] = "󰙨",
          [".spec.js"] = "󰙨",
          [".spec.ts"] = "󰙨",
          [".spec.jsx"] = "󰙨", 
          [".spec.tsx"] = "󰙨",
          [".e2e.js"] = "󰙨",
          [".e2e.ts"] = "󰙨",
          
          -- Frameworks específicos
          [".vue"] = "󰡄",
          [".svelte"] = "󰜈",
          [".astro"] = "󰑣",
          
          -- Estilos
          [".css"] = "",
          [".scss"] = "",
          [".sass"] = "",
          [".less"] = "",
          [".styl"] = "",
          [".stylus"] = "",
          
          -- HTML/Templates  
          [".html"] = "",
          [".htm"] = "",
          [".ejs"] = "",
          [".hbs"] = "",
          [".handlebars"] = "",
          [".pug"] = "",
          [".jade"] = "",
          
          -- Config files
          [".json"] = "",
          [".yaml"] = "",
          [".yml"] = "",
          [".toml"] = "",
          [".xml"] = "󰗀",
          [".ini"] = "",
          [".cfg"] = "",
          [".conf"] = "",
          
          -- Programming languages
          [".py"] = "",
          [".lua"] = "",
          [".rs"] = "",
          [".go"] = "",
          [".java"] = "",
          [".kt"] = "",
          [".swift"] = "󰛥",
          [".php"] = "",
          [".rb"] = "",
          [".c"] = "",
          [".cpp"] = "",
          [".cc"] = "",
          [".h"] = "",
          [".hpp"] = "",
          [".cs"] = "󰌛",
          [".fs"] = "",
          [".hs"] = "",
          [".elm"] = "",
          [".clj"] = "",
          [".ex"] = "",
          [".exs"] = "",
          [".dart"] = "",
          [".r"] = "󰟔",
          [".R"] = "󰟔",
          [".jl"] = "",
          [".scala"] = "",
          [".sh"] = "",
          [".bash"] = "",
          [".zsh"] = "",
          [".fish"] = "",
          
          -- Database
          [".sql"] = "",
          [".db"] = "",
          [".sqlite"] = "",
          [".sqlite3"] = "",
          
          -- Documentation  
          [".md"] = "",
          [".mdx"] = "",
          [".txt"] = "󰈙",
          [".pdf"] = "",
          [".doc"] = "",
          [".docx"] = "",
          [".rtf"] = "",
          
          -- Images
          [".png"] = "󰋩",
          [".jpg"] = "󰋩",
          [".jpeg"] = "󰋩",
          [".gif"] = "󰋩",
          [".svg"] = "󰜡",
          [".ico"] = "󰋩",
          [".webp"] = "󰋩",
          [".bmp"] = "󰋩",
          
          -- Media
          [".mp4"] = "",
          [".avi"] = "",
          [".mov"] = "",
          [".wmv"] = "",
          [".mp3"] = "󰈣",
          [".wav"] = "󰈣",
          [".flac"] = "󰈣",
          [".ogg"] = "󰈣",
          
          -- Archives
          [".zip"] = "",
          [".tar"] = "",
          [".gz"] = "",
          [".rar"] = "",
          [".7z"] = "",
          [".xz"] = "",
          [".bz2"] = "",
          
          -- === CARPETAS ESPECÍFICAS ===
          ["node_modules"] = "",
          [".git"] = "",
          [".github"] = "",
          [".vscode"] = "",
          [".idea"] = "",
          ["dist"] = "",
          ["build"] = "",
          ["public"] = "",
          ["static"] = "",
          ["assets"] = "",
          ["images"] = "󰋩",
          ["icons"] = "󰜡",
          ["components"] = "",
          ["pages"] = "",
          ["src"] = "",
          ["lib"] = "",
          ["libs"] = "",
          ["packages"] = "",
          ["utils"] = "",
          ["helpers"] = "",
          ["hooks"] = "",
          ["contexts"] = "",
          ["providers"] = "",
          ["services"] = "",
          ["api"] = "",
          ["styles"] = "",
          ["css"] = "",
          ["scss"] = "",
          ["sass"] = "",
          ["tests"] = "󰙨",
          ["__tests__"] = "󰙨",
          ["test"] = "󰙨",
          ["spec"] = "󰙨",
          ["e2e"] = "󰙨",
          ["cypress"] = "󰙨",
          ["playwright"] = "󰙨",
          ["docs"] = "",
          ["documentation"] = "",
          ["doc"] = "",
          ["config"] = "",
          ["configs"] = "",
          ["configuration"] = "",
          ["scripts"] = "",
          ["bin"] = "",
          ["vendors"] = "",
          ["vendor"] = "",
          ["tmp"] = "",
          ["temp"] = "",
          ["cache"] = "",
          [".cache"] = "",
          ["logs"] = "",
          ["log"] = "",
          ["prisma"] = "󰔶",
          ["database"] = "󰆼",
          ["db"] = "󰆼",
          ["migrations"] = "󰆼",
          ["seeds"] = "󰆼",
          
          -- === TIPOS GENERALES (fallback) ===
          ["dir"] = "",
          ["file"] = "",
          ["pipe"] = "󰟥",
          ["socket"] = "󰐧", 
          ["executable"] = "",
          ["symlink-dir"] = "",
          ["symlink-file"] = "",
          ["device-char"] = "",
          ["device-block"] = "󰜫",
          ["special"] = "",
        },
      },
    },

    float = {
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
      win_options = { winblend = 0 },
      preview_split = "auto",
      override = function(conf)
        return conf
      end,
    },

    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = { winblend = 0 },
      update_on_cursor_moved = true,
    },

    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = "rounded",
      minimized_border = "none",
      win_options = { winblend = 0 },
    },

    ssh = {
      border = "rounded",
    },
  },

  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },

  config = function(_, opts)
    require("oil").setup(opts)
    
    -- Configurar colores específicos para cada tipo de archivo
    local function setup_oil_colors()
      -- JavaScript (amarillo)
      vim.api.nvim_set_hl(0, "OilJS", { fg = "#f9e2af", bold = true })
      
      -- TypeScript (azul)  
      vim.api.nvim_set_hl(0, "OilTS", { fg = "#89b4fa", bold = true })
      
      -- React (azul claro)
      vim.api.nvim_set_hl(0, "OilReact", { fg = "#74c7ec", bold = true })
      
      -- Vue (verde)
      vim.api.nvim_set_hl(0, "OilVue", { fg = "#a6e3a1", bold = true })
      
      -- Testing (rojo/rosa)
      vim.api.nvim_set_hl(0, "OilTest", { fg = "#f38ba8", bold = true })
      
      -- Docker (azul océano)
      vim.api.nvim_set_hl(0, "OilDocker", { fg = "#89dceb", bold = true })
      
      -- Bun (naranja/rosa)
      vim.api.nvim_set_hl(0, "OilBun", { fg = "#fab387", bold = true })
      
      -- Prisma/Database (verde agua)
      vim.api.nvim_set_hl(0, "OilDB", { fg = "#94e2d5", bold = true })
      
      -- CSS (rosa)
      vim.api.nvim_set_hl(0, "OilCSS", { fg = "#f38ba8", bold = true })
      
      -- HTML (naranja)  
      vim.api.nvim_set_hl(0, "OilHTML", { fg = "#fab387", bold = true })
      
      -- JSON (amarillo)
      vim.api.nvim_set_hl(0, "OilJSON", { fg = "#f9e2af", bold = true })
      
      -- YAML (morado)
      vim.api.nvim_set_hl(0, "OilYAML", { fg = "#cba6f7", bold = true })
      
      -- Env files (amarillo oscuro)
      vim.api.nvim_set_hl(0, "OilEnv", { fg = "#e6c384", bold = true })
      
      -- Markdown (verde agua)
      vim.api.nvim_set_hl(0, "OilMarkdown", { fg = "#94e2d5", bold = true })
      
      -- Imágenes (morado)
      vim.api.nvim_set_hl(0, "OilImage", { fg = "#cba6f7", bold = true })
      
      -- Media (rosa)
      vim.api.nvim_set_hl(0, "OilMedia", { fg = "#f38ba8", bold = true })
      
      -- Archives (gris)
      vim.api.nvim_set_hl(0, "OilArchive", { fg = "#9399b2", bold = true })
      
      -- Carpetas especiales
      vim.api.nvim_set_hl(0, "OilNodeModules", { fg = "#f38ba8", bold = true })
      vim.api.nvim_set_hl(0, "OilGit", { fg = "#fab387", bold = true })
      vim.api.nvim_set_hl(0, "OilSrc", { fg = "#a6e3a1", bold = true })
      vim.api.nvim_set_hl(0, "OilComponents", { fg = "#74c7ec", bold = true })
      vim.api.nvim_set_hl(0, "OilTests", { fg = "#f38ba8", bold = true })
      
      -- Colores por defecto
      vim.api.nvim_set_hl(0, "OilDir", { fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "OilFile", { fg = "#cdd6f4", bold = false })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        setup_oil_colors() -- Configurar colores cuando se abra oil
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"

        vim.api.nvim_create_autocmd("BufLeave", {
          buffer = 0,
          callback = function()
            if vim.bo.modified then
              vim.cmd("silent! write")
            end
          end,
        })
      end,
    })

    vim.keymap.set("n", "<leader>-", function()
      local oil = require("oil")
      local current_buf = vim.api.nvim_get_current_buf()
      local current_file = vim.api.nvim_buf_get_name(current_buf)

      if current_file and current_file ~= "" then
        local dir = vim.fn.fnamemodify(current_file, ":h")
        oil.open(dir)
      else
        oil.open()
      end
    end, { desc = "Open Oil in current file's directory" })
  end,
}