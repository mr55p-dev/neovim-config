local M = {
	winshift = {}
}

function M.autosession()
	local function close_neo_tree()
		require 'neo-tree.sources.manager'.close_all()
		vim.notify('closed all')
	end

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

function M.pomodoro()
	require('pomodoro').setup {
	  time_work = 25,
	  time_break = 5,
	  time_break_long = 15,
	  timers_to_long_break = 4
	}

	vim.keymap.set('n', '<Leader>ps', function() vim.cmd('PomodoroStart') end, { silent = false })
	vim.keymap.set('n', '<Leader>px', function() vim.cmd('PomodoroStop') end, { silent = false })
	vim.keymap.set('n', '<Leader>pp', function() vim.cmd('PomodoroStatus') end, { silent = false })
end

function M.winshift.setup()
	vim.keymap.set('n', '<C-w><CR>', function() vim.cmd'WinShift' end, {})
end

M.winshift.keys = {
	'<C-w><CR>'
}

function M.dashboard()
	local home = os.getenv('HOME')
	local db = require('dashboard')

	db.preview_command = 'cat | lolcat -F 0.3'
	-- db.preview_command = 'cat'
	db.preview_file_height = 6
	db.preview_file_width = 55
	db.preview_file_path = home .. '/.config/nvim/dashboard_cover.cat'
	db.custom_center = {
	{ icon = '  ',
		desc = 'Recently latest session                 ',
		shortcut = 'SPC s l',
		action = 'SessionLoad' },
	-- { icon = '  ',
	--   desc = 'Recently opened files                   ',
	--   action = 'DashboardFindHistory',
	--   shortcut = 'SPC f h' },
	{ icon = '  ',
		desc = 'Find  File                              ',
		action = 'Telescope find_files find_command=rg,--hidden,--files',
		shortcut = 'SPC f f' },
	-- { icon = '  ',
	--   desc = 'File Browser                            ',
	--   action = 'Telescope find_files',
	--   shortcut = 'SPC f b' },
	{ icon = '  ',
		desc = 'Find  word                              ',
		action = 'Telescope live_grep',
		shortcut = 'SPC f w' },
	{ icon = '  ',
		desc = 'Open Personal dotfiles                  ',
		action = 'Telescope find_files hidden=true path=' .. home .. '/.config/nvim',
		shortcut = 'SPC f d' },
	}
end

function M.pop()
	vim.ui.select = require"popui.ui-overrider"
	vim.ui.input = require"popui.input-overrider"

	vim.api.nvim_set_keymap("n", ",d", ':lua require"popui.diagnostics-navigator"()<CR>', { noremap = true, silent = true, desc="Show diagnostics navigator" })
	vim.api.nvim_set_keymap("n", ",m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true, desc="Show marks navigator" })
end

function M.animate()
	require('mini.animate').setup()
end

function M.notify()
	require("notify").setup({
		background_colour = "#000000",
	})
end

return M
