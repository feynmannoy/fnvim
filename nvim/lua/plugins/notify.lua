return {
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			fps = 60,
			background_colour = "NotifyBackground",
			timeout = 1500,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			stages = "slide",
		},
		config = function(_, opts)
			-- vim.opt.termguicolors = true
			require("notify").setup(opts)
			vim.notify = require("notify")
			vim.api.nvim_set_keymap('n', '<leader>fy', ':Telescope notify<CR>', {noremap = true, silent = true})
		end,
	}
