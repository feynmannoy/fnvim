return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },
      { "<F7>", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
      { "<F7>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tl", "<cmd>lua _lazygit_toggle()<cr>", desc = "lazygit" },
    },
    config = function() 
		local Terminal  = require('toggleterm.terminal').Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
		function _lazygit_toggle()
			lazygit:toggle()
		end
		require("toggleterm").setup( {
			highlights = {
			  Normal = { link = "Normal" },
			  NormalNC = { link = "NormalNC" },
			  NormalFloat = { link = "NormalFloat" },
			  FloatBorder = { link = "FloatBorder" },
			  StatusLine = { link = "StatusLine" },
			  StatusLineNC = { link = "StatusLineNC" },
			  WinBar = { link = "WinBar" },
			  WinBarNC = { link = "WinBarNC" },
			},
			size = 10,
			on_create = function()
			  vim.opt.foldcolumn = "0"
			  vim.opt.signcolumn = "no"
			end,
			open_mapping = "<F7>",
			shading_factor = 2,
			direction = "float",
			float_opts = { border = "rounded" },
		  })
		end
  	},
}

