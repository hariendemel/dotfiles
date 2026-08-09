vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/nvim-mini/mini.nvim",
}

require("mason").setup()

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("gr", vim.lsp.buf.references, "References")
    map("gri", vim.lsp.buf.implementation, "Implementation")
    map("gra", vim.lsp.buf.code_action, "Code action")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>f", vim.lsp.buf.format, "Format buffer")
    map("df", vim.diagnostic.open_float, "Show line diagnostics")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "LSP format on save",
  callback = function(args)
    if vim.lsp.buf.format_supported and vim.lsp.buf.format_supported(args.buf) then
      vim.lsp.buf.format({ bufnr = args.buf })
    end
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
})

