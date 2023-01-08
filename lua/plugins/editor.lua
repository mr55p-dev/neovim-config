local M = {}

function M.comment()
	require('Comment').setup()
end

function M.autopairs()
	require('nvim-autopairs').setup()
end

function M.surround()
	require('nvim-surround').setup()
end

M.hop = {
	keys = {
		"f",
		"F",
		"t",
		"T",
		"<Leader>hw",
	}
}

function M.hop.config()
	local hop = require('hop')
	local directions = require('hop.hint').HintDirection
	vim.keymap.set('', 'f', function()
	  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set('', 'F', function()
	  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set('', 't', function()
	  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set('', 'T', function()
	  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })
	vim.keymap.set('', '<Leader>hw', function()
	  hop.hint_words()
	end, { remap = true })
	hop.setup {}
end

function M.tabout()
	require('tabout').setup {
		tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
		backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
		act_as_tab = true, -- shift content if tab out is not possible
		act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
		default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
		default_shift_tab = '<C-d>', -- reverse shift default action,
		enable_backwards = true, -- well ...
		completion = true, -- if the tabkey is used in a completion pum
		tabouts = {
			{ open = "'", close = "'" },
			{ open = '"', close = '"' },
			{ open = '`', close = '`' },
			{ open = '(', close = ')' },
			{ open = '[', close = ']' },
			{ open = '{', close = '}' }
		},
		ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
		exclude = {} -- tabout will ignore these filetypes
	}
end

function M.glance()
	local glance = require('glance')
	local actions = glance.actions

	glance.setup{
		height = 18, -- Height of the window
		border = {
			enable = false, -- Show window borders. Only horizontal borders allowed
			top_char = '―',
			bottom_char = '―',
		},
	}

	vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>')
	vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
	vim.keymap.set('n', 'gy', '<CMD>Glance type_definitions<CR>')
	vim.keymap.set('n', 'gm', '<CMD>Glance implementations<CR>')
end

return M
