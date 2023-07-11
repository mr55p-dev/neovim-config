local M = {
	winshift = {}
}

function M.autosession()
	require('auto-session').setup {
		auto_session_create_enabled = false,
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_use_git_branch = true,
		bypass_session_save_file_types = { "neo-tree" },
		pre_save_cmds = {
			function() require 'neo-tree.sources.manager'.close_all() end,
		},
		cwd_change_handling = {
			restore_upcoming_session = true
		},
	}

	-- vim.keymap.set('n', '<Leader>ssw', function() vim.cmd'SaveSession' end, {})
	-- vim.keymap.set('n', '<Leader>ssl', function() vim.cmd'RestoreSession' end, {})
end

return {
	"djoshea/vim-autoread", -- Auto-reload files from disk
	{
		"sindrets/winshift.nvim",
		keys = {
			{ '<C-w><CR>', function() vim.cmd [[WinShift]] end, desc = "Winshift" }
		},
		event = "WinEnter",
	}, -- Winshift
	{
		"willothy/flatten.nvim",
		config = true,
	},
	{
		"hood/popui.nvim",
		config = function()
			vim.ui.select = require "popui.ui-overrider"
			vim.ui.input = require "popui.input-overrider"

			vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>',
				{ noremap = true, silent = true, desc = "Show diagnostics navigator" })
			vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>',
				{ noremap = true, silent = true, desc = "Show marks navigator" })
		end,
	},


}
