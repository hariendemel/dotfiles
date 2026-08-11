vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-mini/mini.nvim",
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.opt.termguicolors = true

require("nvim-tree").setup({
    renderer = {
        root_folder_modifier = ":t",
    },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Bring focus back to file tree" })

local bufRemove = require("mini.bufremove")
bufRemove.setup()

local bufferline = require("bufferline")
bufferline.setup({
    options = {
        separator_style = "slant",

        close_command = function(bufnr)
            bufRemove.delete(bufnr, false)
        end,

        offsets = {
            {
                filetype = "NvimTree",
                text = function()
                    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                end,
                highlight = "Directory",
                text_align = "left",
            },
        },
    },
})

vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>bc", function()
    bufRemove.delete(0, false)
end, { desc = "Close buffer" })


require("lualine").setup()

require("mini.cmdline").setup()

require("mini.notify").setup({
    -- only show messages
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})
