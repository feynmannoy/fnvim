return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		opts = function(plugin)
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
			}
		end,
	},
}
