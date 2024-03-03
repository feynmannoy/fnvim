
local M = {}

M = {
		{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
		},
 		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		opts = function(plugin)
			return {
      			auto_clean_after_session_restore = true,
      			close_if_last_window = true,
				window = {
				  position = "left",
				  width = 30,
				  mapping_options = {
					noremap = true,
					nowait = true,
				  },
				  mappings = {
					['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
      				['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
      				['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
					["/"] = "noop",
					["<space>"] = { 
						"toggle_node", 
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
					},
					["<2-LeftMouse>"] = "open",
					["l"] = "open",
					["h"] = "close_node",
					["z"] = "close_all_nodes",
					["a"] = { 
					  "add",
					  config = {
						show_path = "none" -- "none", "relative", "absolute"
					  }
					},
					["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
					["q"] = "none",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				  }
				},
				event_handlers = {
					-- {
					--   event = "neo_tree_buffer_enter",
					--   handler = function()
					-- 	vim.cmd("highlight! Cursor blend=100")
					--   end,
					-- },
					-- {
					--   event = "neo_tree_buffer_leave",
					--   handler = function()
					-- 	vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
					--   end,
					-- },
					--{
						--event = "file_opened",
						--handler = function(file_path)
						  ---- auto close
						  ---- vimc.cmd("Neotree close")
						  ---- OR
						  --require("neo-tree.command").execute({ action = "close" })
						--end
					  --},
			  },
			}
		end,
	}
}

return M 
