local M = {}

function M.gitsigns()
	require('gitsigns').setup {
	  signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	  },
	}
end

function M.fugitive()
	vim.keymap.set('n', '<Leader>gg', ":Git ")
	vim.keymap.set('n', '<Leader>gl', function() vim.cmd("Git lg") end, { silent = true })
end

return M
