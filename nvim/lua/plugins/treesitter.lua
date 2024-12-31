return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	cmd = {
		"TSInstall",
		"TSModuleInfo",
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true, disable = { "python" } },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			"bash",
			"bibtex",
			"c",
			"html",
			"javascript",
			"json",
			"latex",
			"lua",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"yaml",
			"go",
			"thrift",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<cr>",
				node_incremental = "<cr>",
				scope_incremental = "<nop>",
				node_decremental = "<bs>",
			},
		},
		fold = {
			enable = true,
		},
	},
	config = function(_, opts)
		-- Folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldenable = true
		require("nvim-treesitter.configs").setup(opts)
	end,
}
