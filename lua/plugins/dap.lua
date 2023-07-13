return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			require('dap-go').setup()
			require('jester').setup({
				path_to_jest_run = "./node_modules/jest/bin/jest.js",
				path_to_jest_debug = "./node_modules/jest/bin/jest.js",
				terminal_cmd = ":split | terminal",
			})
		end,
		keys = {
			{ "<leader>dc", function() require("dap").continue() end,          desc = "Continue debug adapter" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>jr", function() require "jester".run() end,             desc = "Jester run nearest" },
			{ "<leader>jR", function() require "jester".run_last() end,        desc = "Jester rerun last" },
			{ "<leader>jf", function() require "jester".run_file() end,        desc = "Jester run file" },
			{ "<leader>jd", function() require "jester".debug_file() end,      desc = "Jester debug nearest" },
		},
		dependencies = {
			{ "leoluz/nvim-dap-go" },
			{ "David-Kunz/jester" },
		}
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		config = true,
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{ "<leader>du", function() require('dapui').toggle() end, desc = "Open debugger UI" },
		},
	},

}
