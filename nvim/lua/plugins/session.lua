-- Lua
return {
	"olimorris/persisted.nvim",
	lazy = true,
	keys = {
		{ "<leader>ss", "<cmd>Telescope persisted<CR>" },
	},
	config = function()
		require("persisted").setup({
			-- 想看 data 位置的话：echo fnamemodify(stdpath('data'), ':p')
			save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
			silent = false, -- silent nvim message when sourcing session file
			use_git_branch = false, -- create session files based on the branch of a git enabled repository
			default_branch = "main", -- the branch to load if a session file is not found for the current branch
			autosave = true, -- automatically save session files when exiting Neovim
			should_autosave = nil, -- function to determine if a session should be autosaved
			autoload = false, -- automatically load the session for the cwd on Neovim startup
			on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
			follow_cwd = true, -- change session file name to match current working directory if it changes
			allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
			ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
			ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
			telescope = {
				reset_prompt = true, -- Reset the Telescope prompt after an action?
				mappings = { -- table of mappings for the Telescope extension
					change_branch = "<c-b>",
					copy_session = "<c-c>",
					delete_session = "<c-d>",
				},
				icons = { -- icons displayed in the picker, set to nil to disable entirely
					branch = " ",
					dir = " ",
					selected = " ",
				},
			},
		})
		local group = vim.api.nvim_create_augroup("PersistedHooks", {})
		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "PersistedLoadPost",
			group = group,
			callback = function(session)
				vim.api.nvim_input("<ESC>:Neotree toggle <CR>")
			end,
		})
	end,
}
