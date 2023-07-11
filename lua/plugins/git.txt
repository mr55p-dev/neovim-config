local function showFugitiveGit()
	if vim.fn.FugitiveHead() ~= "" then
		vim.cmd([[
    Git
    setlocal nonumber
    setlocal norelativenumber
    ]])
	end
end

local function toggleFugitiveGit()
	if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
		vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
	else
		showFugitiveGit()
	end
end

return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{
				{ "n", "i", "v", "t" },
				"<F3>",
				toggleFugitiveGit,
				desc = "Open fugitive"
			},
			{ "<Leader>gg",  "<cmd>Git<CR>",                                     desc = "Open Git" },
			{ "<Leader>gcc", "<cmd>Git commit ",                                 desc = "Open Git commit" },
			{ "<Leader>gca", function() vim.cmd("Git commit -a") end,            desc = "Commit all" },
			{ "<Leader>gce", function() vim.cmd("Git commit --allow-empty") end, desc = "Commit empty" },
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
