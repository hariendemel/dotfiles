vim.pack.add {
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/nvim-mini/mini.nvim",
}

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Show Neogit UI" })

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open diff view" })
vim.keymap.set("n", "<leader>q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
vim.keymap.set("n", "<leader>gl", "<cmd>DiffviewFileHistory<CR>", { desc = "Git file history" })
vim.keymap.set("n", "<leader>glc", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git file history (current file)" })

local miniDiff = require("mini.diff")
miniDiff.setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "▎" },
	},
})

vim.keymap.set("n", "<leader>hp", function()
	miniDiff.toggle_overlay()
end, { desc = "Preview diff overlay" })

vim.keymap.set("n", "<leader>gb", function()
	require("mini.git").show_at_cursor()
end, { desc = "Git blame/show" })

