vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
})

local miniFiles = require("mini.files")
miniFiles.setup()

vim.keymap.set("n", "-", function()
    miniFiles.open()
end, { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
    miniFiles.open(vim.api.nvim_buf_get_name(0), false)
    miniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

local miniPick = require("mini.pick")
miniPick.setup()
vim.keymap.set("n", "<leader>pf", function()
    miniPick.builtin.files()
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>pF", function()
    miniPick.builtin.cli({
        command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--color=never" },
    })
end, { desc = "Mini File Picker (including hidden files)" })
vim.keymap.set("n", "<leader>ps", function()
    miniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Grep word/Search word" })
vim.keymap.set("n", "<leader>vh", function()
    miniPick.builtin.help()
end, { desc = "Mini Help" })

local miniExtra = require("mini.extra")
miniExtra.setup()
vim.keymap.set("n", "<leader>xx", function()
    miniExtra.pickers.diagnostic()
end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>pk", function()
    miniExtra.pickers.keymaps()
end, { desc = "Search keymaps" })
