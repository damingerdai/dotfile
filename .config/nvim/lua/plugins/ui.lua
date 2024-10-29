return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "moll/vim-bbye",
      "nvim-tree/nvim-web-devicons",
    },
    envet = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffer" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffer to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffer to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bc", ":Bdelete!<CR>", desc = "Close Buffer " },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    envet = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons"}},
    opts = function(_, opts)
      local logo = [[

            .___              .__                                .___      .__ 
          __| _/____    _____ |__| ____    ____   ___________  __| _/____  |__|
        / __ |\__  \  /     \|  |/    \  / ___\_/ __ \_  __ \/ __ |\__  \ |  |
        / /_/ | / __ \|  Y Y  \  |   |  \/ /_/  >  ___/|  | \/ /_/ | / __ \|  |
        \____ |(____  /__|_|  /__|___|  /\___  / \___  >__|  \____ |(____  /__|
            \/     \/      \/        \//_____/      \/           \/     \/    
              
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
    end,
  }
}
