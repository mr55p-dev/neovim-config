return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader><space>",
				function() require('telescope.builtin').git_files({ hidden = true }) end,
				desc = "Find git files"
			},
			{
				"<leader>/",
				function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
					.get_dropdown { previewer = false, }) end,
				desc = "[/] Fuzzily search in current buffer]"
			},
			{
				"<leader>sf",
				require('telescope.builtin').find_files,
				desc = "[S]earch [F]iles"
			},
			{
				"<leader>sb",
				require('telescope.builtin').buffers,
				desc = "[S]earch [B]uffers"
			},
			{
				"<leader>so",
				require('telescope.builtin').oldfiles,
				desc = "[S]earch [O]ld"
			},
			{
				"<leader>sd",
				require('telescope.builtin').lsp_document_symbols,
				desc = "[S]earch [D]ocument"
			},
			{
				"<leader>ss",
				require('telescope.builtin').lsp_dynamic_workspace_symbols,
				desc = "[S]earch [S]ymbols"
			},
			{
				"<leader>sw",
				require('telescope.builtin').grep_string,
				desc = "[S]earch current [W]ord"
			},
			{
				"<leader>sg",
				require('telescope.builtin').live_grep,
				desc = "[S]earch by [G]rep"
			},
			{
				"<leader>sr",
				require('telescope.builtin').resume,
				desc = "[S]earch [R]esume"
			},
			{
				"<leader>sh",
				require('telescope.builtin').help_tags,
				desc = "[S]earch [H]elp"
			},
			{
				"<C-p>",
				function() vim.cmd [[Telescope]] end,
				desc = "All commands"
			},
			{
				"<C-A-p>",
				require('telescope.builtin').commands,
				desc = "All commands"
			},
		}
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	}, -- Terminal
}
