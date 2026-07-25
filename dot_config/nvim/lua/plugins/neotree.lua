return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    vim.keymap.set("n", "<C-1>", "<Cmd>Neotree<CR>")

    require("neo-tree").setup({
      close_if_last_window = true,
    })
  end
}
