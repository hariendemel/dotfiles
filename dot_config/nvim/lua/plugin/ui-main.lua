vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  "https://github.com/nvim-tree/nvim-tree.lua",
  'https://github.com/nvim-mini/mini.nvim',
}

require('catppuccin').setup({
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme 'catppuccin-mocha'

require("bufferline").setup()

require('lualine').setup()

vim.opt.termguicolors = true
require("nvim-tree").setup({
  renderer = {
    root_folder_modifier = ":t",
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Bring focus back to file tree" })

require('mini.cmdline').setup()

require('mini.notify').setup({
  -- only show messages
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})
