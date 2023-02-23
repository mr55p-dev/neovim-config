local M = {
	floatterm = {},
	toggleterm = {},
}

function M.toggleterm.setup()
	require('toggleterm').setup{
		open_mapping = [[<C-\>]]
	}
end

M.toggleterm.keys = {
	[[<C-\>]]
}

function M.floatterm.setup()
	vim.keymap.set('n', '<Leader>tt', function() vim.cmd('FloatermToggle') end)
	vim.keymap.set('n', '<Leader>tn',
	function() vim.cmd('FloatermNew --height=0.7 --width=0.7 --wintype=float --name=nnn nnn') end)
	vim.keymap.set('n', '<Leader>gt',
	function() vim.cmd('FloatermNew --height=0.9 --width=0.9 --wintype=float --name=Git lazygit') end)
	vim.keymap.set('n', '<Leader>ts', function () vim.cmd('FloatermNew --height=0.7 --width=0.7 --wintype=float --name=spt spt') end)
end

M.floatterm.keys = {
	"<Leader>tt",
	"<Leader>tn",
	"<Leader>gt",
}

return M

