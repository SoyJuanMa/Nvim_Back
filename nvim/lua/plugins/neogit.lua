return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    disable_signs = true,
    graph_style = "unicode",
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
}
