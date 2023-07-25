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
			{ "<F5>",       function() require("dap").continue() end,          desc = "Continue debug adapter" },
			{ "<leader>dh", function() require("dap").run_to_cursor() end,     desc = "Run until cursor" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{
				"<Leader>dp",
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				desc = "Toggle log breakpoint"
			},
			{ "<leader>dj", function() require("dap").step_into() end,    desc = "Step into frame" },
			{ "<leader>dJ", function() require("dap").down() end,    desc = "View below frame" },
			{ "<leader>dl", function() require("dap").step_over() end,    desc = "Step over" },
			{ "<F6>",       function() require("dap").step_over() end,    desc = "Step over" },
			{ "<leader>dk", function() require("dap").step_out() end,     desc = "Step out of frame" },
			{ "<leader>dK", function() require("dap").up() end,     desc = "View above frame" },
			{ "<leader>dx", function() require("dap").terminate() end,    desc = "Kill active debug target" },
			{ "<leader>dr", function() require("dap").restart() end,      desc = "Restart current debug target" },
			{ "<leader>dt", function() require('dap-go').debug_test() end,      desc = "Debug test" },
			{ "<leader>dT", function() require('dap-go').debug_last_test() end,      desc = "Debug last test" },
			{ "<leader>jr", function() require "jester".run() end,        desc = "Jester run nearest" },
			{ "<leader>jR", function() require "jester".run_last() end,   desc = "Jester rerun last" },
			{ "<leader>jf", function() require "jester".run_file() end,   desc = "Jester run file" },
			{ "<leader>jd", function() require "jester".debug_file() end, desc = "Jester debug nearest" },
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
