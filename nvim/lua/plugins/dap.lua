local function setup_dap()
	-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
	local dap = require("dap")

	------------------------- cpp -------------------------
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = "/Users/bytedance/.local/share/nvim/mason/bin/codelldb",
			args = { "--port", "${port}" },
		},
	}
	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			runInTerminal = false, -- 确保这一行存在
		},
	}

	------------------------- go -------------------------
	dap.adapters.delve = {
		type = "server",
		port = "${port}",
		executable = {
			command = "dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
	}
	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
		{
			type = "delve",
			name = "Debug test",
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		{
			type = "delve",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}
end

local function setup_keymaps()
	local dap = require("dap")

	-- 设置按键绑定
	vim.keymap.set("n", "<F5>", function()
		dap.continue()
	end)
	vim.keymap.set("n", "<F10>", function()
		dap.step_over()
	end)
	vim.keymap.set("n", "<F11>", function()
		dap.step_into()
	end)
	vim.keymap.set("n", "<leader>dc", function()
		dap.disconnect()
	end)
end

local function setup_dapui()
	local dap = require("dap")
	local dapui = require("dapui")

	-- 设置 dapui
	require("dapui").setup()

	-- 设置调试事件的监听器
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	keys = {
		{ "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "breakpoint set" },
	},
	config = function()
		setup_dap()
		setup_keymaps()
		setup_dapui()
	end,
}
