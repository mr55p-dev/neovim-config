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
		'<Leader>gcc',
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

	vim.keymap.set('n', '<Leader>gcc', ":Git commit ")
	vim.keymap.set('n', '<Leader>gca', function() vim.cmd("Git commit -a") end)
	vim.keymap.set('n', '<Leader>gce', function() vim.cmd("Git commit --allow-empty") end)
	vim.keymap.set('n', '<Leader>gcf', function() vim.cmd("Git commit --no-verify") end)

	vim.keymap.set('n', '<Leader>ga', ":Git add ")
	vim.keymap.set('n', '<Leader>gA', function() vim.cmd("Git add .") end)
end

function M.gh()
	require('litee.lib').setup()
	require('litee.gh').setup({
	keymaps = {
		open = "<CR>",
		-- when inside a gh.nvim panel, expand a collapsed node
		expand = "zo",
		collapse = "zc",
		-- when cursor is over a "#1234" formatted issue or PR, open its details
		-- and comments in a new tab.
		goto_issue = "gd",
		-- show any details about a node, typically, this reveals commit messages
		-- and submitted review bodys.
		details = "d",
		-- inside a convo buffer, submit a comment
		submit_comment = "<C-s>",
		-- inside a convo buffer, when your cursor is ontop of a comment, open
		-- up a set of actions that can be performed.
		actions = "<C-a>",
		-- inside a thread convo buffer, resolve the thread.
		resolve_thread = "<C-r>",
		-- inside a gh.nvim panel, if possible, open the node's web URL in your
		-- browser. useful particularily for digging into external failed CI
		-- checks.
		goto_web = "gx"
	}
	})
end

return M
