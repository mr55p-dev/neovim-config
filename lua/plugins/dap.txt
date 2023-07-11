local M = {}

function M.dap()
	local dap = require('dap')
	require('dap-go').setup()
	require('jester').setup({
		path_to_jest_run = "./node_modules/jest/bin/jest.js",
		path_to_jest_debug = "./node_modules/jest/bin/jest.js",
		terminal_cmd = ":split | terminal",
	})
	vim.keymap.set("n", "<leader>jr", function() require"jester".run() end, { desc = "Jester run nearest"})
	vim.keymap.set("n", "<leader>jR", function() require"jester".run_last() end, { desc = "Jester rerun last"})
	vim.keymap.set("n", "<leader>jf", function() require"jester".run_file() end, { desc = "Jester run file"})
	vim.keymap.set("n", "<leader>jd", function() require"jester".debug_file() end, { desc = "Jester debug nearest"})

	vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue debug adapter" })
	vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })

end

function M.dap_ui()
	local dapui = require('dapui')
	dapui.setup()
	vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Open debugger UI" })
end

return M
