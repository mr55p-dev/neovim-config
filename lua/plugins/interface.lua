local M = {}


function M.lualine()
	-- Override 'encoding': Don't display if encoding is UTF-8.
	local encoding = function()
	  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
	  return ret
	end
	-- fileformat: Don't display if &ff is unix.
	local fileformat = function()
	  local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
	  return ret
	end

	require('lualine').setup {
	  options = {
		icons_enabled = true,
		theme = 'nord',
		component_separators = '|',
		section_separators = '',
	  },
	  sections = {
		lualine_c = {
		  { 'filename', path=1 },
		  -- require('pomodoro').statusline
		},
		lualine_x = { 'filetype', 'windows', 'tabs' },
		lualine_y = { encoding(), 'progress', fileformat() }
	  }
	}
end

function M.neotree()
	vim.cmd('let g:neo_tree_remove_legacy_commands = 1')

	require('neo-tree').setup({
		close_if_last_window = true,
		filesystem = {
			follow_current_file = true
		}
	})

	vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>Neotree left toggle<CR>', { silent = true })
	vim.api.nvim_set_keymap('n', '<C-A-n>', '<cmd>Neotree float toggle<CR>', { silent = true })
end

function M.codewindow()
	local codewindow = require 'codewindow'
	codewindow.setup {}
	codewindow.apply_default_keybinds()
end

function M.blankline()
	require('indent_blankline').setup {
	char = '┊',
	show_trailing_blankline_indent = false,
	}
end

return M
