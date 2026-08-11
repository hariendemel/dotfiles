vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/stevearc/conform.nvim",
})

require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "terraform-ls",
        "bash-language-server",
        "basedpyright",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "yaml-language-server",
        "marksman",
        "dockerfile-language-server",
        "stylua",
        "shfmt",
        "ruff",
        "prettier",
    },
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        python = { "ruff_format" },
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
    },
    format_on_save = function(bufnr)
        if vim.b[bufnr].autosave_in_progress then
            return nil
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
})

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
        map("<leader>f", function()
            require("conform").format({ bufnr = bufnr, lsp_format = "fallback" })
        end, "Format buffer")
        map("df", vim.diagnostic.open_float, "Show line diagnostics")
        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.config("bashls", {
    filetypes = { "bash", "sh", "zsh" },
})

vim.lsp.enable({
    "lua_ls",
    "terraformls",
    "bashls",
    "basedpyright",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "marksman",
    "dockerls",
})
