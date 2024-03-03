return {
	-- {
	-- 	"Th3Whit3Wolf/onebuddy",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	dependencies = "tjdevries/colorbuddy.vim",
	-- 	config = function()
	-- 		require('colorbuddy').colorscheme('onebuddy')
	-- 	end
	-- },
	-- { 
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000 ,
	-- 	config = true,
	-- 	config = function() 
	-- 		require("gruvbox").setup({
	-- 		  terminal_colors = true, -- add neovim terminal colors
	-- 		  undercurl = true,
	-- 		  underline = true,
	-- 		  bold = false,
	-- 		  italic = {
	-- 			strings = false,
	-- 			emphasis = true,
	-- 			comments = true,
	-- 			operators = false,
	-- 			folds = true,
	-- 		  },
	-- 		  strikethrough = true,
	-- 		  invert_selection = false,
	-- 		  invert_signs = false,
	-- 		  invert_tabline = false,
	-- 		  invert_intend_guides = false,
	-- 		  inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 		  contrast = "", -- can be "hard", "soft" or empty string
	-- 		  palette_overrides = {},
	-- 		  overrides = {},
	-- 		  dim_inactive = false,
	-- 		  transparent_mode = false,
	-- 		   overrides = {
	-- 				-- ["@lsp.type.method"] = { fg = "#000000" },
	-- 				-- ["@comment.lua"] = { bg = "#000000" },
	-- 		   }
	-- 		})
	-- 		-- require("gruvbox").load()
	-- 	end
	-- }
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme vscode]])
	-- 	end
	-- },
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
		end
	}
}
