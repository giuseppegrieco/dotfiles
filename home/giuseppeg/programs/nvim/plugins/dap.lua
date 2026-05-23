return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()
		require("dap-go").setup()

		local debugpy = vim.fn.exepath("debugpy-adapter") ~= "" and "debugpy-adapter" or "python3"
		require("dap-python").setup(debugpy)

		require("nvim-dap-virtual-text").setup({
			-- best-effort masking to reduce the chance of leaking secrets in inline values
			display_callback = function(variable)
				local name = string.lower(variable.name)
				local value = string.lower(variable.value)
				if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
					return "*****"
				end
				if #variable.value > 15 then
					return " " .. string.sub(variable.value, 1, 15) .. "... "
				end
				return " " .. variable.value
			end,
		})

		-- codelldb for rust / c / c++ (binary comes from pkgs.vscode-extensions.vadimcn.vscode-lldb via extraPackages)
		local codelldb = vim.fn.exepath("codelldb")
		if codelldb ~= "" then
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb,
					args = { "--port", "${port}" },
				},
			}
			for _, ft in ipairs({ "rust", "c", "cpp" }) do
				dap.configurations[ft] = {
					{
						name = "Launch (codelldb)",
						type = "codelldb",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
					},
				}
			end
		end

		-- elixir-ls debugger, only if present
		local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
		if elixir_ls_debugger ~= "" then
			dap.adapters.mix_task = {
				type = "executable",
				command = elixir_ls_debugger,
			}
			dap.configurations.elixir = {
				{
					type = "mix_task",
					name = "phoenix server",
					task = "phx.server",
					request = "launch",
					projectDir = "${workspaceFolder}",
					exitAfterTaskReturns = false,
					debugAutoInterpretAllModules = false,
				},
			}
		end

		-- toggle a breakpoint on the current line
		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		-- run program to the current cursor position
		vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
		-- evaluate the variable under the cursor in a floating dapui window
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		-- continue / step / restart on function keys
		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F13>", dap.restart)

		dap.listeners.before.attach.dapui_config = function() ui.open() end
		dap.listeners.before.launch.dapui_config = function() ui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
		dap.listeners.before.event_exited.dapui_config = function() ui.close() end
	end,
}
