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
	require("telescope").load_extension("notify")
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
	vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[S]earch [S]ymbols' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
	vim.keymap.set('n', '<leader>sn', require('telescope').extensions.notify.notify, { desc = '[S]earch [N]otify' })
end

M.keys = {
	'<leader>?',
	'<leader><space>',
	'<leader>/',
	'<leader>sf',
	'<leader>ss',
	'<leader>sw',
	'<leader>sg',
	'<leader>sr',
	'<leader>sn',
}

return M

