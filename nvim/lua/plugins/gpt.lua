return {
  "jackMort/ChatGPT.nvim",
  	keys = {
      { "<leader>gt", "<cmd>ChatGPT<cr>", desc = "ChatGPT float" },
      { "<leader>ge", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGpt with edit" },
	},
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
}
