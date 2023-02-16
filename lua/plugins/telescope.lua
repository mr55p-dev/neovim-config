local M = {}

function M.setup()
	require('telescope').setup {
	  defaults = {
	    mappings = {
	      i = {
		['<C-u>'] = false,
		['<C-d>'] = false,
	      },
	    },
	  },
	}

	-- Enable telescope fzf native, if installed
	-- pcall(require('telescope').load_extension, 'fzf')

	-- See `:help telescope.builtin`
	vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>/', function()
	  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
	    winblend = 10,
	    previewer = false,
	  })
	end, { desc = '[/] Fuzzily search in current buffer]' })

	vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', require('telescope.builtin').lsp_document_symbols, { desc = '[S]earch [D]ocument symbols' })
	vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_workspace_symbols, { desc = '[S]earch [S]ymbols' })
end

M.keys = {
	'<leader>?',
	'<leader><space>',
	'<leader>/',
	'<leader>sf',
	'<leader>sh',
	'<leader>sw',
	'<leader>sg',
	'<leader>sd',
}

return M
