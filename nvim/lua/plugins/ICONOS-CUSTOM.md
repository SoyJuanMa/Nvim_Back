# Cómo agregar iconos personalizados en nvim-web-devicons

Este archivo documenta cómo personalizar los iconos en Neovim usando `nvim-web-devicons`.

## 📍 Archivo de configuración

**Ubicación**: `~/.config/nvim/lua/plugins/nvim-web-devicons.lua`

## 🎨 Tipos de personalización

### 1. Iconos por extensión de archivo

Se configuran en la tabla `opts.override`. Usa la **extensión** sin el punto.

```lua
opts.override = vim.tbl_extend("force", opts.override or {}, {
  -- Ejemplo: Archivos .js
  js = { 
    icon = "󰌞",           -- Icono (requiere Nerd Font)
    color = "#f9e2af",    -- Color en formato hex
    name = "Js"           -- Nombre interno (se agrega "DevIcon" automáticamente)
  },
  
  -- Ejemplo: Archivos .vue
  vue = { icon = "", color = "#a6e3a1", name = "Vue" },
})
```

### 2. Iconos por nombre exacto de archivo

Se configuran en la tabla `opts.override_by_filename`. Usa el **nombre completo** del archivo.

```lua
opts.override_by_filename = vim.tbl_extend("force", opts.override_by_filename or {}, {
  -- Ejemplo: package.json
  ["package.json"] = { 
    icon = "", 
    color = "#a6e3a1", 
    name = "PackageJson" 
  },
  
  -- Ejemplo: .gitignore
  [".gitignore"] = { icon = "", color = "#f38ba8", name = "GitIgnore" },
  
  -- Ejemplo: Dockerfile
  ["Dockerfile"] = { icon = "󰡨", color = "#89dceb", name = "Dockerfile" },
})
```

### 3. Iconos por nombre de carpeta

Se configuran en la tabla `opts.override_by_folder_name`. Usa el **nombre exacto** de la carpeta.

```lua
opts.override_by_folder_name = vim.tbl_extend("force", opts.override_by_folder_name or {}, {
  -- Ejemplo: node_modules
  node_modules = { 
    icon = "", 
    color = "#a6e3a1", 
    name = "NodeModules" 
  },
  
  -- Ejemplo: carpeta src
  src = { icon = "", color = "#89dceb", name = "Src" },
  
  -- Ejemplo: carpeta components
  components = { icon = "", color = "#74c7ec", name = "Components" },
  
  -- Ejemplo: carpeta .git
  [".git"] = { icon = "", color = "#f38ba8", name = "Git" },
})
```

## 🎯 Cómo agregar un icono custom

### Paso 1: Encuentra el icono que querés usar

Opciones:
1. **Nerd Fonts Cheat Sheet**: https://www.nerdfonts.com/cheat-sheet
2. **Material Design Icons**: https://pictogrammers.com/library/mdi/

### Paso 2: Copia el carácter del icono

Ejemplo: `` (icono de React)

### Paso 3: Elige un color

Usa colores en formato hex. Ejemplos:
- `#f9e2af` (amarillo)
- `#89b4fa` (azul)
- `#a6e3a1` (verde)
- `#f38ba8` (rojo)
- `#cba6f7` (morado)
- `#fab387` (naranja)
- `#74c7ec` (cyan)

### Paso 4: Agrega la configuración

Edita `~/.config/nvim/lua/plugins/nvim-web-devicons.lua` y agrega tu icono en la sección correspondiente:

**Para extensión de archivo**:
```lua
opts.override = vim.tbl_extend("force", opts.override or {}, {
  -- ... otros iconos ...
  
  -- Tu nuevo icono
  miextension = { icon = "", color = "#89b4fa", name = "MiExtension" },
})
```

**Para archivo específico**:
```lua
opts.override_by_filename = vim.tbl_extend("force", opts.override_by_filename or {}, {
  -- ... otros iconos ...
  
  -- Tu nuevo archivo
  ["mi-archivo.config"] = { icon = "", color = "#f9e2af", name = "MiArchivoConfig" },
})
```

**Para carpeta**:
```lua
opts.override_by_folder_name = vim.tbl_extend("force", opts.override_by_folder_name or {}, {
  -- ... otros iconos ...
  
  -- Tu nueva carpeta
  ["mi-carpeta"] = { icon = "", color = "#a6e3a1", name = "MiCarpeta" },
})
```

### Paso 5: Reinicia Neovim

```vim
:qa
nvim
:Lazy sync
```

## 📋 Ejemplos prácticos

### Agregar icono para archivos `.astro`

```lua
opts.override = vim.tbl_extend("force", opts.override or {}, {
  astro = { icon = "", color = "#fab387", name = "Astro" },
})
```

### Agregar icono para `vite.config.ts`

```lua
opts.override_by_filename = vim.tbl_extend("force", opts.override_by_filename or {}, {
  ["vite.config.ts"] = { icon = "󱐋", color = "#cba6f7", name = "ViteConfigTs" },
})
```

### Agregar icono para carpeta `test/`

```lua
opts.override_by_folder_name = vim.tbl_extend("force", opts.override_by_folder_name or {}, {
  test = { icon = "󰙨", color = "#a6e3a1", name = "Test" },
})
```

## 🔧 Verificar iconos

Para verificar que tus iconos funcionan, podés usar:

```lua
:lua vim.print(require('nvim-web-devicons').get_icon('archivo.js', 'js', { default = true }))
```

## 📚 Recursos

- **nvim-web-devicons**: https://github.com/nvim-tree/nvim-web-devicons
- **Nerd Fonts**: https://www.nerdfonts.com/
- **Material Design Icons**: https://pictogrammers.com/library/mdi/

## ⚠️ Troubleshooting

### Los iconos no se muestran

1. Verificá que tengas instalada una **Nerd Font** (recomendado: JetBrainsMono Nerd Font, FiraCode Nerd Font)
2. Configurá tu terminal para usar esa fuente
3. Reiniciá Neovim completamente

### Los colores no se ven

Verificá que tu terminal soporte **true color** (24-bit):
```vim
:set termguicolors
```

### Los iconos de carpetas no funcionan en Oil

Asegurate que Oil tenga configurado:
```lua
opts = {
  columns = { "icon" },
}
```

## 💾 Backups

Si cometés un error, tenés backups en:
- `~/.config/nvim/lua/plugins/nvim-web-devicons.lua.backup`

Para restaurar:
```bash
cd ~/.config/nvim/lua/plugins/
cp nvim-web-devicons.lua.backup nvim-web-devicons.lua
```
