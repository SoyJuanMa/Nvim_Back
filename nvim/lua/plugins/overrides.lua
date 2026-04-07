-- This file contains the configuration overrides for specific Neovim plugins.

return {
  -- Change configuration for trouble.nvim
  {
    -- Plugin: trouble.nvim
    -- URL: https://github.com/folke/trouble.nvim
    -- Description: A pretty list for showing diagnostics, references, telescope results, quickfix and location lists.
    "folke/trouble.nvim",
    -- Options to be merged with the parent specification
    opts = { use_diagnostic_signs = true }, -- Use diagnostic signs for trouble.nvim
  },

  -- Add symbols-outline.nvim plugin
  {
    -- Plugin: symbols-outline.nvim
    -- URL: https://github.com/simrat39/symbols-outline.nvim
    -- Description: A tree like view for symbols in Neovim using the Language Server Protocol.
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline", -- Command to open the symbols outline
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } }, -- Keybinding to open the symbols outline
    config = true, -- Use default configuration
  },

  -- Remove inlay hints from default configuration
  {
    -- Plugin: nvim-lspconfig
    -- URL: https://github.com/neovim/nvim-lspconfig
    -- Description: Quickstart configurations for the Neovim LSP client.
    "neovim/nvim-lspconfig",
    event = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
    opts = function(_, opts)
      -- Deshabilitar inlay hints
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.enabled = false

      -- Configurar diagnósticos
      opts.diagnostics = opts.diagnostics or {}
      opts.diagnostics.virtual_text = opts.diagnostics.virtual_text or {}
      opts.diagnostics.virtual_text.source = false -- No mostrar source para evitar duplicados

      -- Inicializar servers
      opts.servers = opts.servers or {}

      -- Configurar Angular LS
      opts.servers.angularls = {
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
        end,
      }

      -- Configurar nil_ls (Nix)
      opts.servers.nil_ls = {
        cmd = { "nil" },
        autostart = true,
        mason = false,
        settings = {
          ["nil"] = {
            formatting = { command = { "nixpkgs-fmt" } },
          },
        },
      }

      -- DESHABILITAR SERVIDORES TS DUPLICADOS
      -- Solo mantener vtsls (el que usa el extra de biome)
      opts.servers.tsserver = false
      opts.servers.ts_ls = false

      return opts
    end,
  },
}
