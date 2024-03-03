function builtin_selector(builtin, opts)
	return function()
		require("telescope.builtin")[builtin](opts or {})
	end
end


return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.5',
  dependencies = {
    { 
		"nvim-telescope/telescope-fzf-native.nvim", 
	   	enabled = vim.fn.executable "make" == 1,
		build = "make"
	},
  },
  cmd = "Telescope",
  keys = {
	  { "<leader>ff", builtin_selector("find_files") },
	  { "<leader>fw", builtin_selector("live_grep") },
  },
  opts = function()
    local actions = require "telescope.actions"
    return {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = { 
			  q = actions.close
		  },
        },
      },
    }
  end,
}

