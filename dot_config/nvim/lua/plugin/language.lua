vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "vim",
    "vimdoc",
    "markdown",
    "yaml",
    "json",
    "csv",
    "bash",
    "zsh",
    "lua",
    "dockerfile",
    "hcl",
    "terraform",
    "html",
    "css",
    "xml",
    "python",
    "typescript",
    "javascript",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local buf = args.buf
        if pcall(vim.treesitter.get_parser, buf) then
            return
        end

        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end

        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then
            return
        end

        pcall(vim.treesitter.start, buf, lang)
    end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
