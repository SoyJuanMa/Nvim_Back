return {
  {
    -- {
    --
    --   "xiyaowong/transparent.nvim",
    --   config = function()
    --     require("transparent").setup({
    --       extra_groups = { -- table/string: additional groups that should be cleared
    --         "Normal",
    --         "NormalNC",
    --         "Comment",
    --         "Constant",
    --         "Special",
    --         "Identifier",
    --         "Statement",
    --         "PreProc",
    --         "Type",
    --         "Underlined",
    --         "Todo",
    --         "String",
    --         "Function",
    --         "Conditional",
    --         "Repeat",
    --         "Operator",
    --         "Structure",
    --         "LineNr",
    --         "NonText",
    --         "SignColumn",
    --         "CursorLineNr",
    --         "EndOfBuffer",
    --       },
    --       exclude_groups = {}, -- table: groups you don't want to clear
    --     })
    --   end,
    -- },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      },
    },
    {
      "Gentleman-Programming/gentleman-kanagawa-blur",
      name = "gentleman-kanagawa-blur",
      priority = 1000,

      config = function()
        require("gentleman_kanagawa_blur").setup({
          terminal_colors = true,
          variant = "blur",

          styles = {
            comments = {},
            keywords = {},
            identifiers = {},
            functions = {},
            variables = {},
            booleans = {},
          },

          integrations = {
            alpha = true,
            cmp = true,
            flash = true,
            gitsigns = true,
            hop = false,
            indent_blankline = true,
            lazy = true,
            lsp = true,
            markdown = true,
            mason = true,
            noice = true,
            notify = true,
            rainbow_delimiters = true,
            telescope = true,
            treesitter = true,
          },

          highlight_overrides = {
            -- vim-illuminate usa estos highlight groups (NO los LspReference*)
            IlluminatedWordText = { bg = "#353545" },
            IlluminatedWordRead = { bg = "#353545" },
            IlluminatedWordWrite = { bg = "#353545" },
            -- También los LspReference por las dudas
            LspReferenceText = { bg = "#353545" },
            LspReferenceRead = { bg = "#353545" },
            LspReferenceWrite = { bg = "#353545" },
          },
        })

        -- Aplicar DESPUÉS también para asegurar que se aplique
        vim.schedule(function()
          vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#353545" })
          vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#353545" })
          vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#353545" })
        end)
      end,
    },
    {
      "Alan-TheGentleman/oldworld.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
      "oxfist/night-owl.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
      "rose-pine/neovim",
      name = "rose-pine",
    },
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      lazy = false,
      config = function()
        require("kanagawa").setup({
          compile = false, -- enable compiling the colorscheme
          undercurl = true, -- enable undercurls
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          typeStyle = {},
          transparent = true, -- do not set background color
          dimInactive = false, -- dim inactive window `:h hl-NormalNC`
          terminalColors = true, -- define vim.g.terminal_color_{0,17}
          colors = { -- add/modify theme and palette colors
            palette = {},
            theme = {
              wave = {},
              lotus = {},
              dragon = {},
              all = {
                ui = {
                  bg_gutter = "none", -- set bg color for normal background
                  bg_sidebar = "none", -- set bg color for sidebar like nvim-tree
                  bg_float = "none", -- set bg color for floating windows
                },
              },
            },
          },
          overrides = function(colors) -- add/modify highlights
            return {
              LineNr = { bg = "none" },
              NormalFloat = { bg = "none" },
              FloatBorder = { bg = "none" },
              FloatTitle = { bg = "none" },
              TelescopeNormal = { bg = "none" },
              TelescopeBorder = { bg = "none" },
              LspInfoBorder = { bg = "none" },
            }
          end,
          theme = "wave", -- Load "dragon" theme
        })
      end,
    },

    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "gentleman-kanagawa-blur",
        --     colorscheme = "kanagawa",
      },
    },
  },
}
