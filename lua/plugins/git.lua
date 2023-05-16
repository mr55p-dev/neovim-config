local M = {}

function M.gitsigns()
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	})
end

M.fugitive = {
	keys = {
		"<Leader>gg",
		"<Leader>gl",
		"<Leader>gs",
		"<Leader>gcc",
		"<Leader>gca",
		"<Leader>gce",
		"<Leader>gcf",
		"<Leader>ga",
		"<Leader>gA",
	},
}

function M.fugitive.setup()
	vim.keymap.set("n", "<Leader>gg", ":Git ", { desc = "Open Git" })
	vim.keymap.set("n", "<Leader>gs", function()
		vim.cmd("Git")
	end, { silent = true, desc = "Git status" })
	vim.keymap.set("n", "<Leader>gl", function()
		vim.cmd("Git lg")
	end, { silent = true, desc = "Git lg" })

	vim.keymap.set("n", "<Leader>gcc", ":Git commit ", { desc = "Open Git commit" })
	vim.keymap.set("n", "<Leader>gca", function()
		vim.cmd("Git commit -a")
	end, { desc = "Commit all" })
	vim.keymap.set("n", "<Leader>gce", function()
		vim.cmd("Git commit --allow-empty")
	end, { desc = "Commit empty" })
	vim.keymap.set("n", "<Leader>gcf", function()
		vim.cmd("Git commit --no-verify")
	end, { desc = "Commit forced (no verify)" })

	vim.keymap.set("n", "<Leader>ga", ":Git add ", { desc = "Open Git add" })
	vim.keymap.set("n", "<Leader>gA", function()
		vim.cmd("Git add .")
	end, { desc = "Add workdir" })
end

function M.octo()
	require("octo").setup()
end

return M
