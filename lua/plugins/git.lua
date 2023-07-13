return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{
				"<F3>",
				function()
					if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
						vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
					else
						if vim.fn.FugitiveHead() ~= "" then
							vim.cmd([[
						Git
						setlocal nonumber
						setlocal norelativenumber
						]])
						end
					end
				end,
				mode = { "n", "i", "v", "t" },
				desc = "Open fugitive"
			},
			{ "<Leader>gg",  ":Git ",                                            desc = "Open Git" },
			{ "<Leader>gcc", ":Git commit ",                                     desc = "Open Git commit" },
			{ "<Leader>gca", function() vim.cmd("Git commit -a") end,            desc = "Commit all" },
			{ "<Leader>gce", function() vim.cmd("Git commit --allow-empty") end, desc = "Commit empty" },
			{
				"<Leader>gs",
				function()
					vim.ui.input({ prompt = "Enter a revision" }, function(input)
						vim.cmd.Gedit({ args = {
							string.format("%s:%%", input) } })
					end)
				end,
				desc = "View changes from previous revision"
			},
			{
				"<Leader>gcf",
				function() vim.cmd("Git commit --no-verify") end,
				desc = "Commit forced (no verify)"
			},
		}
	}, -- Git commands in nvim
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}
