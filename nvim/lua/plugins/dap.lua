return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	keys = {
      { "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "breakpoint set" },
	},
	config = function()
		local dap = require('dap')
		-- more language config : https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- golang
		dap.adapters.delve = {
		  type = 'server',
		  port = '${port}',
		  executable = {
			command = 'dlv',
			args = {'dap', '-l', '127.0.0.1:${port}'},
		  }
		}
		dap.configurations.go = {
		  {
			type = "delve",
			name = "Debug",
			request = "launch",
			program = "${file}"
		  },
		  {
			type = "delve",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}"
		  },
		  -- works with go.mod packages and sub packages 
		  {
			type = "delve",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		  } 
		}
		-- keymapping
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		-- vim.keymap.set("n", "<F9>", function()
		-- 	dap.toggle_breakpoint()
		-- end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dao.step_into()
		end)
		-- vim.keymap.set("n", "<leader>do", function()
		-- 	require("dap").step_out()
		-- end)
		vim.keymap.set("n", "<leader>dc", function()
			dap.disconnect()
    		vim.api.nvim_input(':Neotree toggle<CR>:wincmd l<CR>')
		end)
		-- ui 
		require("dapui").setup()
		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
    		vim.api.nvim_input(':Neotree toggle<CR>')
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,	
}
