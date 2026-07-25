return {
  {
    'akinsho/bufferline.nvim', 
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end
  },

  {
    "leath-dub/snipe.nvim",
 
    keys = {
      {
        "<C-b>", 
        function () 
          require("snipe").open_buffer_menu() 
        end, 
        desc = "Open Snipe buffer menu"
      }
    },

    opts = {}
  },
}

