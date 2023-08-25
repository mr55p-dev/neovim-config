return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
			}, -- Terminal
		},
		config = function(_, opts)
			require("telescope").load_extension("fzf")
			require("telescope").setup(opts)
		end,
		opts = {
			defaults = {
				mappings = {
					n = {
						['<C-d>'] = require('telescope.actions').delete_buffer
					},
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
		},
		lazy = false,
		priority = 10000,
		cmd = "Telescope",
		keys = {
			{
				"<leader><space>",
				function() require('telescope.builtin').git_files({ hidden = true }) end,
				desc = "Find git files"
			},
			{
				[[<leader>/]],
				function()
					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
						.get_dropdown { previewer = false, })
				end,
				desc = "[/] Fuzzily search in current buffer]"
			},
			{
				"<leader>sf",
				function() require('telescope.builtin').find_files() end,
				desc = "[S]earch [F]iles"
			},
			{
				"<leader>sb",
				function() require('telescope.builtin').buffers() end,
				desc = "[S]earch [B]uffers"
			},
			{
				"<leader>sn",
				function() require('telescope.builtin').git_branches() end,
				desc = "[S]earch [N]branches"
				},
			{
				"<leader>so",
				function() require('telescope.builtin').oldfiles() end,
				desc = "[S]earch [O]ld"
			},
			{
				"<leader>sd",
				function() require('telescope.builtin').lsp_document_symbols() end,
				desc = "[S]earch [D]ocument"
			},
			{
				"<leader>ss",
				function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
				desc = "[S]earch [S]ymbols"
			},
			{
				"<leader>sw",
				function() require('telescope.builtin').grep_string() end,
				desc = "[S]earch current [W]ord"
			},
			{
				"<leader>sg",
				function() require('telescope.builtin').live_grep() end,
				desc = "[S]earch by [G]rep"
			},
			{
				"<leader>sr",
				function() require('telescope.builtin').resume() end,
				desc = "[S]earch [R]esume"
			},
			{
				"<leader>sh",
				function() require('telescope.builtin').help_tags() end,
				desc = "[S]earch [H]elp"
			},
			{
				"<C-p>",
				function() vim.cmd [[Telescope]] end,
				desc = "All commands"
			},
			{
				"<C-A-p>",
				function() require('telescope.builtin').commands() end,
				desc = "All commands"
			},
		}
	},
}
