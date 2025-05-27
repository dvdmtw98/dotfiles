return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/opt/codelldb/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.c = {
			{
				name = "Debug File",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.expand('%:r') .. '.o', "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					local argument_string = vim.fn.input("Program arguments: ")
					return vim.fn.split(argument_string, " ", true)
				end,
			},
		}

		dap.configurations.cpp = dap.configurations.c

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dapui.setup()

		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start/Continue Degugging" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into Function" })
		vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "Step Over Function" })
	end,
}
