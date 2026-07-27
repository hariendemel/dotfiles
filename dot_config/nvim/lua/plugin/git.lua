vim.pack.add {
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-mini/mini.nvim",
}

local neogit = require("neogit")
neogit.setup()

vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Show Neogit UI" })

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

