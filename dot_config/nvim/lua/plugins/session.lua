return {
  "rmagatti/auto-session",
  lazy = false,
  enabled = false,

  keys = {
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },

  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({
      auto_restore_last_session = true,
      show_auto_restore_notif = true,
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
    })
  end
}
