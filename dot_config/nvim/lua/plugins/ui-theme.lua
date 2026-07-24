return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },

  {
    'nvim-lualine/lualine.nvim',

    config = function()
      require('lualine').setup({
        options = {
          theme = 'dracula'
        }
      })
    end
  },
}
