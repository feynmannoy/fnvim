-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
-- 	require("plugins.alpha"),
-- 	require("plugins.auto-pairs"),
-- 	require("plugins.bufferline"),
-- 	require("plugins.colortheme"),
-- 	require("plugins.comment"),
-- 	require("plugins.lspconfig"),
-- 	require("plugins.lualine"),
-- 	require("plugins.mason"),
-- 	require("plugins.neo-tree"),
-- 	require("plugins.telescpoe"),
-- 	require("plugins.toggleterm"),
-- })

-- configure lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = { lazy = true, version = false }, -- always use the latest git commit
	-- install = { colorscheme = { "tokyonight", "gruvbox" } },
	checker = { enabled = false }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})




