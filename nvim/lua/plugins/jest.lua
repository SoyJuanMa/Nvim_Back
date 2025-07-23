return {
  "mattkubej/jest.nvim",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    require("nvim-jest").setup({
      jest_cmd = "./node_modules/.bin/jest",
      silent = true,
    })
    vim.keymap.set("n", "<leader>tj", "<cmd>JestFile<CR>", { desc = "Test current file with Jest" })
  end,
}
