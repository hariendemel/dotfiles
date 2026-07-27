vim.pack.add {
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/nvim-mini/mini.nvim",
}

vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<cr>", { desc = "Show Neogit UI" })

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

vim.keymap.set("n", "<leader>hb", function()
	require("mini.git").show_at_cursor()
end, { desc = "Git blame/show" })

