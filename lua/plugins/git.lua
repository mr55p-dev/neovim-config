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


M.fugitive = {
	keys = {
		'<Leader>gg',
		'<Leader>gl',
		'<Leader>gs',
		'<Leader>gc',
		'<Leader>gca',
		'<Leader>gce',
		'<Leader>gcf',
		'<Leader>ga',
		'<Leader>gA',
	}
}

function M.fugitive.setup()
	vim.keymap.set('n', '<Leader>gg', ":Git ")
	vim.keymap.set('n', '<Leader>gl', function() vim.cmd("Git lg") end, { silent = true })
	vim.keymap.set('n', '<Leader>gs', function() vim.cmd("Git status") end, { silent = true })

	vim.keymap.set('n', '<Leader>gc', ":Git commit ")
	vim.keymap.set('n', '<Leader>gca', function() vim.cmd("Git commit -a") end)
	vim.keymap.set('n', '<Leader>gce', function() vim.cmd("Git commit --allow-empty") end)
	vim.keymap.set('n', '<Leader>gcf', function() vim.cmd("Git commit --no-verify") end)

	vim.keymap.set('n', '<Leader>ga', ":Git add ")
	vim.keymap.set('n', '<Leader>gA', function() vim.cmd("Git add .") end)
end

return M
