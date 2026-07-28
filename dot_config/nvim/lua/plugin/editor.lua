vim.pack.add {
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
}

require("mini.comment").setup()

require("mini.surround").setup()

require("mini.ai").setup()

require("mini.completion").setup({
  lsp_completion = {
    auto_setup = true,
  }
})

require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
})

