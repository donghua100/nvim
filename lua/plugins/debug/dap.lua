return {
	-- ============================================================
	-- nvim-dap
	-- ============================================================
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			-- DAP UI
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},

			-- Debug 时显示变量值
			"theHamsta/nvim-dap-virtual-text",

			-- Mason 管理 Debug Adapter
			"jay-babu/mason-nvim-dap.nvim",
		},

		keys = {
			-- ========================================================
			-- Breakpoint
			-- ========================================================

			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},

			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Conditional Breakpoint",
			},

			-- ========================================================
			-- Run
			-- ========================================================

			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},

			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},

			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},

			-- ========================================================
			-- Step
			-- ========================================================

			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},

			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},

			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},

			-- ========================================================
			-- Session
			-- ========================================================

			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},

			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},

			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},

			-- ========================================================
			-- Stack
			-- ========================================================

			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down Stack",
			},

			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up Stack",
			},

			-- ========================================================
			-- DAP UI
			-- ========================================================

			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},

			{
				"<leader>dw",
				function()
					require("dapui").float_element()
				end,
				desc = "DAP Hover",
			},
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- ========================================================
			-- DAP UI
			-- ========================================================

			dapui.setup()

			-- Debug 开始时自动打开 UI
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			-- Debug 结束时自动关闭 UI
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- ========================================================
			-- Virtual Text
			-- ========================================================

			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				commented = false,
				virt_text_pos = "eol",
				all_frames = false,
			})

			-- ========================================================
			-- Signs
			-- ========================================================

			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = "◆",
				texthl = "DapBreakpointCondition",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "✗",
				texthl = "DapBreakpointRejected",
				linehl = "",
				numhl = "",
			})

			-------
			-- ========================================================
			-- C / C++
			-- ========================================================

			dap.adapters.codelldb = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			}

			dap.configurations.cpp = {
				{
					name = "Launch C++",
					type = "codelldb",
					request = "launch",

					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/a.out", "file")
					end,

					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					terminal = "integrated",
				},
			}

			-- C 使用同一套配置
			dap.configurations.c = dap.configurations.cpp
			------

			-- ============================================================
			-- Python
			-- ============================================================

			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = {
					"-m",
					"debugpy.adapter",
				},
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch Python File",

					program = "${file}",

					pythonPath = function()
						return vim.fn.exepath("python3")
					end,

					console = "integratedTerminal",

					justMyCode = false,
				},
			}
		end,
	},

	-- ============================================================
	-- Mason DAP
	-- ============================================================
	{
		"jay-babu/mason-nvim-dap.nvim",

		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},

		opts = {
			automatic_installation = false,

			ensure_installed = {
				-- C / C++
				"codelldb",

				-- Python
				"debugpy",

				"java-debug-adapter",
			},
		},
	},
}
