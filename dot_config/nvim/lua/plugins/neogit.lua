return {
  "NeogitOrg/neogit",
  lazy = true,
  cmd = "Neogit",

  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },

  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
}

