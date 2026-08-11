vim.pack.add {
  "https://github.com/rmagatti/auto-session",
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local autoSession = require("auto-session")

autoSession.setup({
  auto_restore_last_session = true,
  show_auto_restore_notif = true,
  git_use_branch_name = false,
  git_auto_restore_on_branch_change = false,
})

vim.keymap.set("n", "<leader>sf", "<cmd>AutoSession search<CR>", { desc = "Session search" })
vim.keymap.set("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Session save" })
