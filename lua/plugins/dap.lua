return {
	{
		"mfussenegger/nvim-dap",
		-- "dependencies" meaning that these plugins are required for this plugin to works, if they are not installed, this plugin will not be loaded as well. So when you install this plugin, it will also install these dependencies.
		dependencies = {
			"williamboman/mason.nvim", -- need mason for managing debuggers
			"rcarriga/nvim-dap-ui", -- need dap-ui for debugging UI
			"theHamsta/nvim-dap-virtual-text", -- need dap-virtual-text for virtual text support. For example, when you hover over a variable, it will show the value of that variable.
			"nvim-neotest/nvim-nio", -- need nvim-nio for running tests

			-- Language specific debuggers
			--"NicholasMata/nvim-dap-cs", -- need dap-cs for C# debugging support
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			require("dapui").setup()

			-- keybindings for debugging
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<S-F5>", dap.terminate)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<S-F11>", dap.step_out)

			-- Attach to running process. For example, if you have a running server, you can attach to it and start debugging.
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- handle the debugger for different languages
			--
			-- .NET Core debugger
			--
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg", -- meaning that it will use lldb as the debugger
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = ".NET Core Launch",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},
}
