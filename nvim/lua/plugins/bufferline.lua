return {
	"akinsho/bufferline.nvim",
	event = "BufEnter",
	opts = function(plugin)
		return {
			vim.keymap.set("n", "]b", ":BufferLineCycleNext<CR>", { noremap = true }),
			vim.keymap.set("n", "[b", ":BufferLineCyclePrev<CR>", { noremap = true }),
			vim.keymap.set("n", "<leader>c", ":BufferLineCloseOthers<CR>", { noremap = true }),
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "Working Space",
						text_align = "left",
						separator = true,
					},
				},
			},
		}
	end,
}
