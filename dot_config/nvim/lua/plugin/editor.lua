vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
}

require("mini.comment").setup()

require("mini.surround").setup()

require("mini.ai").setup()

require("mini.completion").setup({
  lsp_completion = {
    auto_setup = true,
  }
})

