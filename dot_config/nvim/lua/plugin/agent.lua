vim.pack.add({
    "https://github.com/ChmaraX/herdr-nvim",
})

require("herdr-nvim").setup({
    prefix = "<leader>,",
    keymaps = true,
    clear_after_send = true,
})
